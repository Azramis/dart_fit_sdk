import 'package:fit_sdk/fit_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('FitProfileCatalog', () {
    late FitProfileCatalog catalog;

    setUp(() {
      catalog = FitProfileCatalog.instance;
    });

    // ── messages ───────────────────────────────────────────────────────────

    group('messages', () {
      test('messages list is non-empty', () {
        expect(catalog.messages, isNotEmpty);
      });

      test('messageByNum(20) returns the record message', () {
        final record = catalog.messageByNum(20);
        expect(record, isNotNull);
        expect(record!.num, equals(20));
        expect(record.name.toLowerCase(), contains('record'));
      });

      test('record message contains heart-rate field (num 3)', () {
        final record = catalog.messageByNum(20)!;
        final hrField =
            record.fields.where((f) => f.num == 3).toList();
        expect(hrField, hasLength(1));
        expect(hrField.first.name, isNotEmpty);
        expect(hrField.first.units, equals('bpm'));
      });

      test('messageByName returns the same object as messageByNum', () {
        final byNum = catalog.messageByNum(20)!;
        final byName = catalog.messageByName(byNum.name);
        expect(byName, isNotNull);
        expect(byName!.num, equals(byNum.num));
      });

      test('messageByName is case-insensitive', () {
        final byNum = catalog.messageByNum(20)!;
        final upper = catalog.messageByName(byNum.name.toUpperCase());
        final lower = catalog.messageByName(byNum.name.toLowerCase());
        expect(upper?.num, equals(byNum.num));
        expect(lower?.num, equals(byNum.num));
      });

      test('messageByNum returns null for unknown num', () {
        expect(catalog.messageByNum(999999), isNull);
      });

      test('messageByName returns null for unknown name', () {
        expect(catalog.messageByName('__no_such_message__'), isNull);
      });

      test('all messages have non-empty name and non-negative num', () {
        for (final m in catalog.messages) {
          expect(m.name, isNotEmpty,
              reason: 'message num ${m.num} has empty name');
          expect(m.num, greaterThanOrEqualTo(0),
              reason: 'message ${m.name} has negative num');
        }
      });
    });

    // ── fields ─────────────────────────────────────────────────────────────

    group('FieldInfo', () {
      test('record heart-rate field has correct metadata', () {
        final record = catalog.messageByNum(20)!;
        final hr = record.fields.firstWhere((f) => f.num == 3);
        expect(hr.units, equals('bpm'));
        expect(hr.scale, isNonNegative);
        expect(hr.offset, isNotNull);
        expect(hr.profileType, equals(ProfileType.uint8));
      });
    });

    // ── enumTypes ──────────────────────────────────────────────────────────

    group('enumTypes', () {
      test('enumTypes list is non-empty', () {
        expect(catalog.enumTypes, isNotEmpty);
      });

      test('enumType(ProfileType.sport) is not null', () {
        expect(catalog.enumType(ProfileType.sport), isNotNull);
      });

      test('sport enum has "running" (value 1)', () {
        final sport = catalog.enumType(ProfileType.sport)!;
        expect(sport.nameOf(1), equals('running'));
      });

      test('sport enum has "cycling" (value 2)', () {
        final sport = catalog.enumType(ProfileType.sport)!;
        expect(sport.nameOf(2), equals('cycling'));
      });

      test('sport enum values list contains running and cycling', () {
        final sport = catalog.enumType(ProfileType.sport)!;
        final names = sport.values.map((v) => v.name).toList();
        expect(names, contains('running'));
        expect(names, contains('cycling'));
      });

      test('sport EnumTypeInfo.name equals "sport"', () {
        final sport = catalog.enumType(ProfileType.sport)!;
        expect(sport.name, equals('sport'));
      });

      test('sport EnumTypeInfo.type equals ProfileType.sport', () {
        final sport = catalog.enumType(ProfileType.sport)!;
        expect(sport.type, equals(ProfileType.sport));
      });

      test('nameOf unknown value returns null', () {
        final sport = catalog.enumType(ProfileType.sport)!;
        expect(sport.nameOf(9999), isNull);
      });

      test('base type sint8 returns null from enumType', () {
        expect(catalog.enumType(ProfileType.sint8), isNull);
      });

      test('base type uint8 returns null from enumType', () {
        expect(catalog.enumType(ProfileType.uint8), isNull);
      });

      test('dateTime returns null from enumType', () {
        expect(catalog.enumType(ProfileType.dateTime), isNull);
      });

      test('all enumTypes have non-empty values list', () {
        for (final et in catalog.enumTypes) {
          expect(et.values, isNotEmpty,
              reason: 'enum type ${et.name} has empty values list');
        }
      });

      test('all EnumValueInfo entries have non-empty names', () {
        for (final et in catalog.enumTypes) {
          for (final v in et.values) {
            expect(v.name, isNotEmpty,
                reason: 'enum ${et.name} has a value with empty name (value=${v.value})');
          }
        }
      });
    });

    // ── singleton ──────────────────────────────────────────────────────────

    group('singleton', () {
      test('FitProfileCatalog.instance returns the same object', () {
        expect(
          identical(FitProfileCatalog.instance, FitProfileCatalog.instance),
          isTrue,
        );
      });
    });
  });
}
