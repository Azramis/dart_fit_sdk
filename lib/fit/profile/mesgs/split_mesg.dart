import '../../defines.dart';
import '../../mesg.dart';
import '../../profile.dart';
import '../types/mesg_num.dart';
import '../types/types.dart';

class SplitMesg extends Mesg {
  static const int fieldMessageIndex = 254;
  static const int fieldSplitType = 0;
  static const int fieldTotalElapsedTime = 1;
  static const int fieldTotalTimerTime = 2;
  static const int fieldTotalDistance = 3;
  static const int fieldAvgSpeed = 4;
  static const int fieldStartTime = 9;
  static const int fieldTotalAscent = 13;
  static const int fieldTotalDescent = 14;
  static const int fieldStartPositionLat = 21;
  static const int fieldStartPositionLong = 22;
  static const int fieldEndPositionLat = 23;
  static const int fieldEndPositionLong = 24;
  static const int fieldMaxSpeed = 25;
  static const int fieldAvgVertSpeed = 26;
  static const int fieldEndTime = 27;
  static const int fieldTotalCalories = 28;
  static const int fieldStartElevation = 74;
  static const int fieldTotalMovingTime = 110;
  static const int fieldActiveTime = 78;
  static const int fieldTimestamp = 253;
  static const int fieldSport = 11;
  static const int fieldSubSport = 12;
  static const int fieldAvgHeartRate = 15;
  static const int fieldMaxHeartRate = 16;
  static const int fieldNecLat = 17;
  static const int fieldNecLong = 18;
  static const int fieldSwcLat = 19;
  static const int fieldSwcLong = 20;
  static const int fieldAvgCadence = 29;
  static const int fieldMaxCadence = 30;
  static const int fieldTotalCycles = 31;
  static const int fieldAvgTemperature = 32;
  static const int fieldMaxTemperature = 33;
  static const int fieldMinTemperature = 34;
  static const int fieldAvgVerticalOscillation = 35;
  static const int fieldAvgVerticalRatio = 36;
  static const int fieldAvgStanceTime = 37;
  static const int fieldAvgStanceTimeBalance = 38;
  static const int fieldAvgStepLength = 39;
  static const int fieldAvgPower = 40;
  static const int fieldMaxPower = 41;
  static const int fieldNormalizedPower = 42;
  static const int fieldLeftRightBalance = 43;
  static const int fieldTimeStanding = 44;
  static const int fieldAvgLeftPco = 45;
  static const int fieldAvgRightPco = 46;
  static const int fieldAvgLeftPowerPhase = 47;
  static const int fieldAvgLeftPowerPhasePeak = 48;
  static const int fieldAvgRightPowerPhase = 49;
  static const int fieldAvgRightPowerPhasePeak = 50;
  static const int fieldAvgPowerPosition = 51;
  static const int fieldMaxPowerPosition = 52;
  static const int fieldAvgLeftTorqueEffectiveness = 53;
  static const int fieldAvgRightTorqueEffectiveness = 54;
  static const int fieldAvgLeftPedalSmoothness = 55;
  static const int fieldAvgRightPedalSmoothness = 56;
  static const int fieldAvgCombinedPedalSmoothness = 57;
  static const int fieldAvgFlow = 58;
  static const int fieldTotalGrit = 59;
  static const int fieldSwimStroke = 62;
  static const int fieldNumActiveLengths = 63;
  static const int fieldAvgSwolf = 64;
  static const int fieldAvgStrokeDistance = 65;
  static const int fieldAvgStrokesPerLength = 66;
  static const int fieldFirstLapIndex = 67;
  static const int fieldNumLaps = 68;
  static const int fieldClimbGradingScale = 69;
  static const int fieldClimbGradeValue = 70;
  static const int fieldStatus = 71;
  static const int fieldNumFalls = 72;
  static const int fieldClimbSend = 73;
  static const int fieldMetabolicCalories = 79;
  static const int fieldTotalFractionalAscent = 80;
  static const int fieldTotalFractionalDescent = 81;
  static const int fieldAvgGrade = 88;
  static const int fieldMaxGrade = 89;
  static const int fieldMinCadence = 90;
  static const int fieldAvgGradeAdjustedSpeed = 93;
  static const int fieldAvgStress = 94;
  static const int fieldAvgVam = 99;
  static const int fieldJumpCount = 104;
  static const int fieldDiveSectionType = 112;
  static const int fieldAvgAscentRate = 113;
  static const int fieldMaxAscentRate = 114;
  static const int fieldAvgDescentRate = 115;
  static const int fieldMaxDescentRate = 116;
  static const int fieldTotalAscentTime = 117;
  static const int fieldTotalDescentTime = 118;
  static const int fieldTotalHangTime = 119;
  static const int fieldApneaDiscipline = 120;
  static const int fieldAvgDepth = 121;
  static const int fieldMaxDepth = 122;
  static const int fieldMinHeartRate = 124;
  static const int fieldSurfaceInterval = 127;
  static const int fieldTotalFractionalCycles = 142;
  static const int fieldAvgStanceTimePercent = 144;
  static const int fieldTotalAnaerobicTrainingEffect = 168;
  static const int fieldFrontGearShiftCount = 169;
  static const int fieldRearGearShiftCount = 170;
  static const int fieldInvalid = Fit.fieldNumInvalid;

  SplitMesg() : super.from(Profile.getMesg(MesgNum.split));
  SplitMesg.fromMesg(super.mesg) : super.from();

  int? getMessageIndex() {
    final val = getFieldValue(
      254,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSplitType() {
    final val = getFieldValue(
      0,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTotalElapsedTime() {
    final val = getFieldValue(
      1,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalTimerTime() {
    final val = getFieldValue(
      2,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalDistance() {
    final val = getFieldValue(
      3,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgSpeed() {
    final val = getFieldValue(
      4,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  DateTime? getStartTime() {
    final val = getFieldValue(
      9,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            (val as int) * 1000 + 631065600000,
          );
  }

  int? getTotalAscent() {
    final val = getFieldValue(
      13,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getTotalDescent() {
    final val = getFieldValue(
      14,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getStartPositionLat() {
    final val = getFieldValue(
      21,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getStartPositionLong() {
    final val = getFieldValue(
      22,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEndPositionLat() {
    final val = getFieldValue(
      23,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEndPositionLong() {
    final val = getFieldValue(
      24,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getMaxSpeed() {
    final val = getFieldValue(
      25,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgVertSpeed() {
    final val = getFieldValue(
      26,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  DateTime? getEndTime() {
    final val = getFieldValue(
      27,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            (val as int) * 1000 + 631065600000,
          );
  }

  int? getTotalCalories() {
    final val = getFieldValue(
      28,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getStartElevation() {
    final val = getFieldValue(
      74,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalMovingTime() {
    final val = getFieldValue(
      110,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getActiveTime() {
    final val = getFieldValue(
      78,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

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

  int? getSport() {
    final val = getFieldValue(
      11,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSubSport() {
    final val = getFieldValue(
      12,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgHeartRate() {
    final val = getFieldValue(
      15,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxHeartRate() {
    final val = getFieldValue(
      16,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNecLat() {
    final val = getFieldValue(
      17,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNecLong() {
    final val = getFieldValue(
      18,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSwcLat() {
    final val = getFieldValue(
      19,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSwcLong() {
    final val = getFieldValue(
      20,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgCadence() {
    final val = getFieldValue(
      29,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxCadence() {
    final val = getFieldValue(
      30,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getTotalCycles() {
    final val = getFieldValue(
      31,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgTemperature() {
    final val = getFieldValue(
      32,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxTemperature() {
    final val = getFieldValue(
      33,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMinTemperature() {
    final val = getFieldValue(
      34,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgVerticalOscillation() {
    final val = getFieldValue(
      35,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgVerticalRatio() {
    final val = getFieldValue(
      36,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStanceTime() {
    final val = getFieldValue(
      37,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStanceTimeBalance() {
    final val = getFieldValue(
      38,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStepLength() {
    final val = getFieldValue(
      39,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgPower() {
    final val = getFieldValue(
      40,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxPower() {
    final val = getFieldValue(
      41,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNormalizedPower() {
    final val = getFieldValue(
      42,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getLeftRightBalance() {
    final val = getFieldValue(
      43,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTimeStanding() {
    final val = getFieldValue(
      44,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgLeftPco() {
    final val = getFieldValue(
      45,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgRightPco() {
    final val = getFieldValue(
      46,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgLeftPowerPhase() {
    final val = getFieldValue(
      47,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgLeftPowerPhasePeak() {
    final val = getFieldValue(
      48,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightPowerPhase() {
    final val = getFieldValue(
      49,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightPowerPhasePeak() {
    final val = getFieldValue(
      50,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgPowerPosition() {
    final val = getFieldValue(
      51,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxPowerPosition() {
    final val = getFieldValue(
      52,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgLeftTorqueEffectiveness() {
    final val = getFieldValue(
      53,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightTorqueEffectiveness() {
    final val = getFieldValue(
      54,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgLeftPedalSmoothness() {
    final val = getFieldValue(
      55,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightPedalSmoothness() {
    final val = getFieldValue(
      56,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgCombinedPedalSmoothness() {
    final val = getFieldValue(
      57,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgFlow() {
    final val = getFieldValue(
      58,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalGrit() {
    final val = getFieldValue(
      59,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getSwimStroke() {
    final val = getFieldValue(
      62,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNumActiveLengths() {
    final val = getFieldValue(
      63,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgSwolf() {
    final val = getFieldValue(
      64,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgStrokeDistance() {
    final val = getFieldValue(
      65,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStrokesPerLength() {
    final val = getFieldValue(
      66,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getFirstLapIndex() {
    final val = getFieldValue(
      67,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNumLaps() {
    final val = getFieldValue(
      68,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getClimbGradingScale() {
    final val = getFieldValue(
      69,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getClimbGradeValue() {
    final val = getFieldValue(
      70,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getStatus() {
    final val = getFieldValue(
      71,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNumFalls() {
    final val = getFieldValue(
      72,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getClimbSend() {
    final val = getFieldValue(
      73,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMetabolicCalories() {
    final val = getFieldValue(
      79,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTotalFractionalAscent() {
    final val = getFieldValue(
      80,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalFractionalDescent() {
    final val = getFieldValue(
      81,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgGrade() {
    final val = getFieldValue(
      88,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxGrade() {
    final val = getFieldValue(
      89,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMinCadence() {
    final val = getFieldValue(
      90,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgGradeAdjustedSpeed() {
    final val = getFieldValue(
      93,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgStress() {
    final val = getFieldValue(
      94,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgVam() {
    final val = getFieldValue(
      99,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getJumpCount() {
    final val = getFieldValue(
      104,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getDiveSectionType() {
    final val = getFieldValue(
      112,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgAscentRate() {
    final val = getFieldValue(
      113,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxAscentRate() {
    final val = getFieldValue(
      114,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgDescentRate() {
    final val = getFieldValue(
      115,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxDescentRate() {
    final val = getFieldValue(
      116,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalAscentTime() {
    final val = getFieldValue(
      117,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalDescentTime() {
    final val = getFieldValue(
      118,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalHangTime() {
    final val = getFieldValue(
      119,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getApneaDiscipline() {
    final val = getFieldValue(
      120,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgDepth() {
    final val = getFieldValue(
      121,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxDepth() {
    final val = getFieldValue(
      122,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getMinHeartRate() {
    final val = getFieldValue(
      124,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSurfaceInterval() {
    final val = getFieldValue(
      127,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTotalFractionalCycles() {
    final val = getFieldValue(
      142,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStanceTimePercent() {
    final val = getFieldValue(
      144,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalAnaerobicTrainingEffect() {
    final val = getFieldValue(
      168,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getFrontGearShiftCount() {
    final val = getFieldValue(
      169,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getRearGearShiftCount() {
    final val = getFieldValue(
      170,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }
}
