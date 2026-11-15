import '../../defines.dart';
import '../../mesg.dart';
import '../../profile.dart';
import '../types/mesg_num.dart';
import '../types/types.dart';

class TsbDiverConfigMesg extends Mesg {
  static const int fieldAntId = 0;
  static const int fieldDiverName = 1;
  static const int fieldT1TankpodSwVer = 2;
  static const int fieldLocationEnabled = 3;
  static const int fieldMessagingEnabled = 4;
  static const int fieldT1OwnerAntId = 5;
  static const int fieldInvalid = Fit.fieldNumInvalid;

  TsbDiverConfigMesg() : super.from(Profile.getMesg(MesgNum.tsbDiverConfig));
  TsbDiverConfigMesg.fromMesg(super.mesg) : super.from();

  int? getAntId() {
    final val = getFieldValue(
      0,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  String? getDiverName() {
    final val = getFieldValue(
      1,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val?.toString();
  }

  double? getT1TankpodSwVer() {
    final val = getFieldValue(
      2,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getLocationEnabled() {
    final val = getFieldValue(
      3,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMessagingEnabled() {
    final val = getFieldValue(
      4,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getT1OwnerAntId() {
    final val = getFieldValue(
      5,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }
}
