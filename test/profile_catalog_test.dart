import 'dart:io' as io;

import 'package:fit_sdk/fit/profile/types/profile_docs.dart';
import 'package:fit_sdk/fit_sdk.dart';
import 'package:test/test.dart';

void main() {
  final catalog = FitProfileCatalog();

  group('messages', () {
    test('messageByNum(20) is the record message', () {
      final record = catalog.messageByNum(20);
      expect(record, isNotNull);
      expect(record!.num, 20);
      expect(record.name, 'Record');
    });

    test('messageByName resolves snake_case and PascalCase to one instance',
        () {
      final bySnake = catalog.messageByName('record');
      final byPascal = catalog.messageByName('Record');
      expect(bySnake, isNotNull);
      expect(byPascal, same(bySnake));
      expect(catalog.messageByName('not_a_real_message'), isNull);
    });

    test('record carries the heart-rate field (num 3) with units', () {
      final record = catalog.messageByName('record')!;

      final heartRate = record.fields.firstWhere((f) => f.num == 3);
      expect(heartRate.name, isNotEmpty);
      expect(heartRate.name, 'HeartRate');
      expect(heartRate.units, isNotEmpty);
      expect(heartRate.units, 'bpm');

      // Convenience lookups return the same field.
      expect(record.fieldByNum(3), same(heartRate));
      expect(record.fieldByName('HeartRate'), same(heartRate));
    });

    test('fields flag whether they are arrays, and fixed sizes', () {
      final record = catalog.messageByName('record')!;
      // heart_rate is a single value; compressed_speed_distance (num 8) is [3].
      expect(record.fieldByNum(3)!.isArray, isFalse);
      expect(record.fieldByNum(3)!.arrayLength, isNull);
      expect(record.fieldByNum(8)!.isArray, isTrue);
      expect(record.fieldByNum(8)!.arrayLength, 3);

      // hrv.time is a variable-size array ([N]): no fixed length.
      final hrvTime = catalog.messageByName('hrv')!.fieldByName('Time')!;
      expect(hrvTime.isArray, isTrue);
      expect(hrvTime.arrayLength, isNull);
    });

    test('strings are single values unless declared as string arrays', () {
      expect(catalog.messageByName('sport')!.fieldByName('Name')!.isArray,
          isFalse);
      expect(
          catalog
              .messageByName('field_description')!
              .fieldByName('FieldName')!
              .isArray,
          isTrue);
    });

    test('every message is reachable by its number', () {
      expect(catalog.messages, isNotEmpty);
      for (final m in catalog.messages) {
        expect(catalog.messageByNum(m.num), same(m));
        expect(m.name, isNotEmpty);
      }
    });
  });

  group('enum types', () {
    test('sport maps values to their names', () {
      final sport = catalog.enumType(ProfileType.sport);
      expect(sport, isNotNull);
      expect(sport!.name, 'sport');
      expect(sport.nameOf(1), 'running');
      expect(sport.nameOf(2), 'cycling');
      expect(sport.nameOf(999999), isNull);

      final values = sport.values.map((v) => v.value).toSet();
      expect(values, containsAll(<int>[1, 2]));
    });

    test('every listed enum type has a non-empty value table', () {
      expect(catalog.enumTypes, isNotEmpty);
      for (final e in catalog.enumTypes) {
        expect(e.values, isNotEmpty, reason: '${e.name} should have values');
        expect(catalog.enumType(e.type), same(e));
      }
    });

    test('base numeric and scalar types are not enumerations', () {
      expect(catalog.enumType(ProfileType.sint8), isNull);
      expect(catalog.enumType(ProfileType.uint8), isNull);
      expect(catalog.enumType(ProfileType.enum_), isNull);
      expect(catalog.enumType(ProfileType.dateTime), isNull);
      expect(catalog.enumType(ProfileType.localDateTime), isNull);
    });

    test('doc comments carried by the profile are surfaced', () {
      final sport = catalog.enumType(ProfileType.sport)!;
      final transition = sport.valueOf(3);
      expect(transition, isNotNull);
      expect(transition!.name, 'transition');
      expect(transition.doc, isNotNull);
      expect(transition.doc, contains('transition'));
    });

    test('reserved-word value names are returned verbatim (no _ suffix)', () {
      // BatteryStatus.new is a Dart reserved word: the profile name is "new",
      // not the sanitized identifier "new_".
      final battery = catalog.enumType(ProfileType.batteryStatus)!;
      expect(battery.nameOf(1), 'new');
      expect(battery.values.map((v) => v.name), isNot(contains('new_')));
    });
  });

  group('subfields and components', () {
    test('subfields expose their reference conditions', () {
      // FileId.Product is a dynamic field resolved by the Manufacturer field.
      final product = catalog.messageByNum(0)!.fieldByName('Product')!;
      final names = product.subfields.map((s) => s.name).toList();
      expect(names, containsAll(<String>['FaveroProduct', 'GarminProduct']));

      final favero =
          product.subfields.firstWhere((s) => s.name == 'FaveroProduct');
      expect(favero.references, isNotEmpty);
      // Applies when the Manufacturer field (num 1) equals Favero's id (263).
      expect(favero.references.first.fieldNum, 1);
      expect(favero.references.first.value, 263);
    });

    test('Session.TotalCycles exposes the TotalReps and TotalPushes subfields',
        () {
      // In Garmin's profile order (TotalReps first), which decides between
      // overlapping subfields; SessionTotalCyclesSubfield follows it, as in
      // Garmin's C# SDK.
      final totalCycles = catalog.messageByName('session')!.fieldByNum(10)!;
      expect(totalCycles.name, 'TotalCycles');
      expect(totalCycles.subfields.map((s) => s.name),
          ['TotalReps', 'TotalStrides', 'TotalStrokes', 'TotalPushes']);

      List<(int, Object)> references(SubfieldInfo s) =>
          [for (final r in s.references) (r.fieldNum, r.value)];
      final reps = totalCycles.subfields[SessionTotalCyclesSubfield.TotalReps];
      expect(reps.units, 'reps');
      expect(references(reps), [
        (SessionMesg.fieldSubSport, SubSport.strengthTraining),
        (SessionMesg.fieldSport, Sport.hiit),
      ]);
      final pushes =
          totalCycles.subfields[SessionTotalCyclesSubfield.TotalPushes];
      expect(pushes.units, 'pushes');
      expect(references(pushes), [
        (SessionMesg.fieldSport, Sport.wheelchairPushRun),
        (SessionMesg.fieldSport, Sport.wheelchairPushWalk),
      ]);
    });

    test('decoded sessions resolve TotalCycles to TotalReps and TotalPushes',
        () {
      Mesg roundTrip(int sport, [int subSport = SubSport.generic]) {
        final session = Mesg.fromMesgNum(MesgNum.session)
          ..setFieldValue(SessionMesg.fieldSport, sport)
          ..setFieldValue(SessionMesg.fieldSubSport, subSport)
          ..setFieldValue(SessionMesg.fieldTotalCycles, 1200);
        final encoder = Encode()..open();
        encoder
          ..writeMesgDefinition(MesgDefinition.fromMesg(session))
          ..writeMesg(session);
        final decoded = <Mesg>[];
        (Decode()..onMesg = decoded.add).read(encoder.close());
        return decoded.single;
      }

      final pushes = roundTrip(Sport.wheelchairPushRun);
      expect(pushes.getActiveSubFieldName(SessionMesg.fieldTotalCycles),
          'TotalPushes');
      expect(pushes.getFieldValueByName('TotalPushes'), 1200);

      final reps = roundTrip(Sport.hiit);
      expect(reps.getActiveSubFieldName(SessionMesg.fieldTotalCycles),
          'TotalReps');
      expect(reps.getFieldValueByName('TotalReps'), 1200);

      // Every subfield resolves through its typed getter.
      expect(SessionMesg.fromMesg(roundTrip(Sport.running)).getTotalStrides(),
          1200);
      expect(SessionMesg.fromMesg(roundTrip(Sport.cycling)).getTotalStrokes(),
          1200);
      expect(SessionMesg.fromMesg(reps).getTotalReps(), 1200);
      expect(SessionMesg.fromMesg(pushes).getTotalPushes(), 1200);

      // When references overlap, profile order wins as in Garmin's SDKs: a
      // running session with sub-sport strength training counts reps.
      expect(
          roundTrip(Sport.running, SubSport.strengthTraining)
              .getActiveSubFieldName(SessionMesg.fieldTotalCycles),
          'TotalReps');
    });

    test('components expose their target field and bit width', () {
      // Session.AvgSpeed expands a component into another field.
      final avgSpeed =
          catalog.messageByName('session')!.fieldByName('AvgSpeed');
      expect(avgSpeed, isNotNull);
      expect(avgSpeed!.components, isNotEmpty);
      expect(avgSpeed.components.first.bits, greaterThan(0));
    });
  });

  group('documentation (Profile.xlsx)', () {
    test('comes from a known fit-sdk-tools release', () {
      expect(catalog.docsVersion, matches(RegExp(r'^\d+\.\d+\.\d+$')));
    });

    test('messages carry their comment and section', () {
      final fileId = catalog.messageByName('file_id')!;
      expect(fileId.doc, 'Must be first message in file.');
      expect(fileId.section, isNull); // listed before the first section
      expect(
          catalog.messageByName('record')!.section, 'ACTIVITY FILE MESSAGES');
    });

    test('fields carry their comment when the profile has one', () {
      final session = catalog.messageByName('session')!;
      expect(session.fieldByName('TotalElapsedTime')!.doc,
          'Time (includes pauses)');
      expect(session.fieldByName('TotalTimerTime')!.doc,
          'Timer Time (excludes pauses)');
      // Most fields are undocumented.
      expect(catalog.messageByName('record')!.fieldByNum(3)!.doc, isNull);
    });

    test('subfields carry their comment', () {
      final target =
          catalog.messageByName('workout_step')!.fieldByName('TargetValue')!;
      final hrZone =
          target.subfields.firstWhere((s) => s.name == 'TargetHrZone');
      expect(hrZone.doc, contains('hr zone'));
    });

    test('values sharing a number keep their own comment', () {
      // weatherReport: forecast and hourlyForecast are both 1, and only
      // forecast is documented (deprecated in favour of hourlyForecast).
      final values = catalog.enumType(ProfileType.weatherReport)!.values;
      final forecast = values.firstWhere((v) => v.name == 'forecast');
      final hourly = values.firstWhere((v) => v.name == 'hourlyForecast');
      expect(forecast.value, hourly.value);
      expect(forecast.doc, contains('Deprecated'));
      expect(hourly.doc, isNull);
    });

    test('types carry their base type and comment', () {
      final sportBits = catalog.enumType(ProfileType.sportBits0)!;
      expect(sportBits.baseType, 'uint8z');
      expect(sportBits.doc, contains('Bit field'));

      final sport = catalog.enumType(ProfileType.sport)!;
      expect(sport.baseType, 'enum');
      expect(sport.doc, isNull);

      // Scalar types have no EnumTypeInfo but are documented all the same.
      expect(catalog.enumType(ProfileType.dateTime), isNull);
      expect(catalog.typeDoc(ProfileType.dateTime), contains('1989'));
    });

    test('every documented element exists in the catalog', () {
      // Guards the join between Profile.xlsx and the Dart profile, which is
      // done by message/field number and enum value, never by name.
      final unresolved = <String>{};
      for (final mesg in {
        ...profileMessageSections.keys,
        ...profileMessageDocs.keys,
      }) {
        if (catalog.messageByNum(mesg) == null) unresolved.add('message $mesg');
      }
      profileFieldDocs.forEach((mesg, fields) {
        for (final field in fields.keys) {
          if (catalog.messageByNum(mesg)?.fieldByNum(field) == null) {
            unresolved.add('field $mesg#$field');
          }
        }
      });
      profileSubfieldDocs.forEach((mesg, fields) {
        fields.forEach((field, subfields) {
          final names = catalog
                  .messageByNum(mesg)
                  ?.fieldByNum(field)
                  ?.subfields
                  .map((s) => s.name)
                  .toSet() ??
              const <String>{};
          for (final name in subfields.keys) {
            if (!names.contains(name)) {
              unresolved.add('subfield $mesg#$field.$name');
            }
          }
        });
      });
      profileValueDocs.forEach((type, values) {
        final attached = {
          for (final v in catalog.enumType(type)?.values ?? <EnumValueInfo>[])
            if (v.doc != null) '${v.value}:${v.doc}',
        };
        values.forEach((value, docs) {
          docs.forEach((name, doc) {
            if (!attached.contains('$value:$doc')) {
              unresolved.add('value ${type.name}:$value:$name');
            }
          });
        });
      });

      expect(unresolved, isEmpty);
    });
  });

  group('shape', () {
    test('is a cached singleton', () {
      expect(FitProfileCatalog(), same(FitProfileCatalog()));
    });

    test('exposed collections are unmodifiable', () {
      expect(() => catalog.messages.clear(), throwsUnsupportedError);
      expect(() => catalog.enumTypes.clear(), throwsUnsupportedError);
      expect(
        () => catalog.enumType(ProfileType.sport)!.values.clear(),
        throwsUnsupportedError,
      );
    });
  });

  group('no regression', () {
    test('decodes the bundled Activity.fit and stays consistent with catalog',
        () {
      final bytes = io.File('data/Activity.fit').readAsBytesSync();

      var messageCount = 0;
      final decoder = Decode()
        ..onMesg = (mesg) {
          messageCount++;
          if (mesg.name == 'unknown') return;
          // Anything the codec recognises, the catalog also describes.
          final info = catalog.messageByNum(mesg.num);
          expect(info, isNotNull,
              reason: 'catalog should know ${mesg.name} (${mesg.num})');
          expect(info!.name, mesg.name);
        };

      decoder.read(bytes);
      expect(messageCount, greaterThan(0));
    });
  });
}
