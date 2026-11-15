import '../../defines.dart';
import '../../mesg.dart';
import '../../profile.dart';
import '../types/mesg_num.dart';
import '../types/types.dart';

class TsbSonarMessageEventMesg extends Mesg {
  static const int fieldSonarPacketId = 0;
  static const int fieldDiverLocationAccuracy = 21;
  static const int fieldMessageType = 22;
  static const int fieldMessageSource = 23;
  static const int fieldInvalid = Fit.fieldNumInvalid;

  TsbSonarMessageEventMesg()
      : super.from(Profile.getMesg(MesgNum.tsbSonarMessageEvent));
  TsbSonarMessageEventMesg.fromMesg(super.mesg) : super.from();

  int? getSonarPacketId() {
    final val = getFieldValue(
      0,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getDiverLocationAccuracy() {
    final val = getFieldValue(
      21,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMessageType() {
    final val = getFieldValue(
      22,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMessageSource() {
    final val = getFieldValue(
      23,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }
}
