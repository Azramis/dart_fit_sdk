import 'dart:io' as io;

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

    test('fields flag whether they are arrays', () {
      final record = catalog.messageByName('record')!;
      // heart_rate is a scalar; compressed_speed_distance (num 8) is an array.
      expect(record.fieldByNum(3)!.isArray, isFalse);
      expect(record.fieldByNum(8)!.isArray, isTrue);
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

    test('components expose their target field and bit width', () {
      // Session.AvgSpeed expands a component into another field.
      final avgSpeed =
          catalog.messageByName('session')!.fieldByName('AvgSpeed');
      expect(avgSpeed, isNotNull);
      expect(avgSpeed!.components, isNotEmpty);
      expect(avgSpeed.components.first.bits, greaterThan(0));
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
