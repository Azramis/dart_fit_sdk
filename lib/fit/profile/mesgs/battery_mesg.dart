import '../../defines.dart';
import '../../mesg.dart';
import '../../profile.dart';
import '../types/mesg_num.dart';
import '../types/types.dart';

class BatteryMesg extends Mesg {
  static const int fieldTimestamp = 253;
  static const int fieldCapacity = 2;
  static const int fieldInvalid = Fit.fieldNumInvalid;

  BatteryMesg() : super.from(Profile.getMesg(MesgNum.battery));
  BatteryMesg.fromMesg(super.mesg) : super.from();

  DateTime? getTimestamp() {
    final val = getFieldValue(
      253,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            (val as int) * 1000 + 631065600000,
          );
  }

  int? getCapacity() {
    final val = getFieldValue(
      2,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }
}
