import 'package:fit_sdk/fit_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('setFieldValueByName', () {
    test('sets the value on this message, not on the shared profile', () {
      final session = SessionMesg()..setFieldValueByName('Sport', Sport.hiit);
      expect(session.getFieldValue(SessionMesg.fieldSport), Sport.hiit);

      // Profile.getMesg's fields are shared by every message of that type.
      final profileSport =
          Profile.getMesg(MesgNum.session).getField(SessionMesg.fieldSport)!;
      expect(profileSport.values, isEmpty);
      expect(SessionMesg().getFieldValue(SessionMesg.fieldSport), isNull);
    });

    test('sets a subfield before its main field exists', () {
      final session = SessionMesg()
        ..setFieldValueByName('Sport', Sport.hiit)
        ..setFieldValueByName('TotalReps', 30);
      expect(session.getFieldValueByName('TotalReps'), 30);
      expect(session.getTotalReps(), 30);
      expect(SessionMesg().getFieldValue(SessionMesg.fieldTotalCycles), isNull);
    });

    test('only writes through a subfield this message selects', () {
      // TotalReps is for HIIT or strength training, not running.
      final absent = SessionMesg()
        ..setFieldValueByName('Sport', Sport.running)
        ..setFieldValueByName('TotalReps', 30);
      expect(absent.getFieldValue(SessionMesg.fieldTotalCycles), isNull);

      final present = SessionMesg()
        ..setFieldValueByName('Sport', Sport.running)
        ..setFieldValueByName('TotalCycles', 1200)
        ..setFieldValueByName('TotalReps', 30);
      expect(present.getTotalStrides(), 1200);
    });
  });
}
