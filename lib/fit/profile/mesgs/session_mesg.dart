import '../../defines.dart';
import '../../mesg.dart';
import '../../profile.dart';
import '../types/mesg_num.dart';
import '../types/types.dart';

class SessionTotalCyclesSubfield {
  static const int TotalStrides = 0;
  static const int TotalStrokes = 1;
  static const int active = Fit.subfieldIndexActiveSubfield;
  static const int mainField = Fit.subfieldIndexMainField;
}

class SessionAvgCadenceSubfield {
  static const int AvgRunningCadence = 0;
  static const int active = Fit.subfieldIndexActiveSubfield;
  static const int mainField = Fit.subfieldIndexMainField;
}

class SessionMaxCadenceSubfield {
  static const int MaxRunningCadence = 0;
  static const int active = Fit.subfieldIndexActiveSubfield;
  static const int mainField = Fit.subfieldIndexMainField;
}

class SessionMesg extends Mesg {
  static const int fieldMessageIndex = 254;
  static const int fieldTimestamp = 253;
  static const int fieldEvent = 0;
  static const int fieldEventType = 1;
  static const int fieldStartTime = 2;
  static const int fieldStartPositionLat = 3;
  static const int fieldStartPositionLong = 4;
  static const int fieldSport = 5;
  static const int fieldSubSport = 6;
  static const int fieldTotalElapsedTime = 7;
  static const int fieldTotalTimerTime = 8;
  static const int fieldTotalDistance = 9;
  static const int fieldTotalCycles = 10;
  static const int fieldTotalCalories = 11;
  static const int fieldTotalFatCalories = 13;
  static const int fieldAvgSpeed = 14;
  static const int fieldMaxSpeed = 15;
  static const int fieldAvgHeartRate = 16;
  static const int fieldMaxHeartRate = 17;
  static const int fieldAvgCadence = 18;
  static const int fieldMaxCadence = 19;
  static const int fieldAvgPower = 20;
  static const int fieldMaxPower = 21;
  static const int fieldTotalAscent = 22;
  static const int fieldTotalDescent = 23;
  static const int fieldTotalTrainingEffect = 24;
  static const int fieldFirstLapIndex = 25;
  static const int fieldNumLaps = 26;
  static const int fieldEventGroup = 27;
  static const int fieldTrigger = 28;
  static const int fieldNecLat = 29;
  static const int fieldNecLong = 30;
  static const int fieldSwcLat = 31;
  static const int fieldSwcLong = 32;
  static const int fieldNumLengths = 33;
  static const int fieldNormalizedPower = 34;
  static const int fieldTrainingStressScore = 35;
  static const int fieldIntensityFactor = 36;
  static const int fieldLeftRightBalance = 37;
  static const int fieldEndPositionLat = 38;
  static const int fieldEndPositionLong = 39;
  static const int fieldAvgStrokeCount = 41;
  static const int fieldAvgStrokeDistance = 42;
  static const int fieldSwimStroke = 43;
  static const int fieldPoolLength = 44;
  static const int fieldThresholdPower = 45;
  static const int fieldPoolLengthUnit = 46;
  static const int fieldNumActiveLengths = 47;
  static const int fieldTotalWork = 48;
  static const int fieldAvgAltitude = 49;
  static const int fieldMaxAltitude = 50;
  static const int fieldGpsAccuracy = 51;
  static const int fieldAvgGrade = 52;
  static const int fieldAvgPosGrade = 53;
  static const int fieldAvgNegGrade = 54;
  static const int fieldMaxPosGrade = 55;
  static const int fieldMaxNegGrade = 56;
  static const int fieldAvgTemperature = 57;
  static const int fieldMaxTemperature = 58;
  static const int fieldTotalMovingTime = 59;
  static const int fieldAvgPosVerticalSpeed = 60;
  static const int fieldAvgNegVerticalSpeed = 61;
  static const int fieldMaxPosVerticalSpeed = 62;
  static const int fieldMaxNegVerticalSpeed = 63;
  static const int fieldMinHeartRate = 64;
  static const int fieldTimeInHrZone = 65;
  static const int fieldTimeInSpeedZone = 66;
  static const int fieldTimeInCadenceZone = 67;
  static const int fieldTimeInPowerZone = 68;
  static const int fieldAvgLapTime = 69;
  static const int fieldBestLapIndex = 70;
  static const int fieldMinAltitude = 71;
  static const int fieldPlayerScore = 82;
  static const int fieldOpponentScore = 83;
  static const int fieldOpponentName = 84;
  static const int fieldStrokeCount = 85;
  static const int fieldZoneCount = 86;
  static const int fieldMaxBallSpeed = 87;
  static const int fieldAvgBallSpeed = 88;
  static const int fieldAvgVerticalOscillation = 89;
  static const int fieldAvgStanceTimePercent = 90;
  static const int fieldAvgStanceTime = 91;
  static const int fieldAvgFractionalCadence = 92;
  static const int fieldMaxFractionalCadence = 93;
  static const int fieldTotalFractionalCycles = 94;
  static const int fieldAvgTotalHemoglobinConc = 95;
  static const int fieldMinTotalHemoglobinConc = 96;
  static const int fieldMaxTotalHemoglobinConc = 97;
  static const int fieldAvgSaturatedHemoglobinPercent = 98;
  static const int fieldMinSaturatedHemoglobinPercent = 99;
  static const int fieldMaxSaturatedHemoglobinPercent = 100;
  static const int fieldAvgLeftTorqueEffectiveness = 101;
  static const int fieldAvgRightTorqueEffectiveness = 102;
  static const int fieldAvgLeftPedalSmoothness = 103;
  static const int fieldAvgRightPedalSmoothness = 104;
  static const int fieldAvgCombinedPedalSmoothness = 105;
  static const int fieldSportProfileName = 110;
  static const int fieldSportIndex = 111;
  static const int fieldTimeStanding = 112;
  static const int fieldStandCount = 113;
  static const int fieldAvgLeftPco = 114;
  static const int fieldAvgRightPco = 115;
  static const int fieldAvgLeftPowerPhase = 116;
  static const int fieldAvgLeftPowerPhasePeak = 117;
  static const int fieldAvgRightPowerPhase = 118;
  static const int fieldAvgRightPowerPhasePeak = 119;
  static const int fieldAvgPowerPosition = 120;
  static const int fieldMaxPowerPosition = 121;
  static const int fieldAvgCadencePosition = 122;
  static const int fieldMaxCadencePosition = 123;
  static const int fieldEnhancedAvgSpeed = 124;
  static const int fieldEnhancedMaxSpeed = 125;
  static const int fieldEnhancedAvgAltitude = 126;
  static const int fieldEnhancedMinAltitude = 127;
  static const int fieldEnhancedMaxAltitude = 128;
  static const int fieldAvgLevMotorPower = 129;
  static const int fieldMaxLevMotorPower = 130;
  static const int fieldLevBatteryConsumption = 131;
  static const int fieldAvgVerticalRatio = 132;
  static const int fieldAvgStanceTimeBalance = 133;
  static const int fieldAvgStepLength = 134;
  static const int fieldTotalAnaerobicTrainingEffect = 137;
  static const int fieldAvgVam = 139;
  static const int fieldAvgDepth = 140;
  static const int fieldMaxDepth = 141;
  static const int fieldSurfaceInterval = 142;
  static const int fieldStartCns = 143;
  static const int fieldEndCns = 144;
  static const int fieldStartN2 = 145;
  static const int fieldEndN2 = 146;
  static const int fieldAvgRespirationRate = 147;
  static const int fieldMaxRespirationRate = 148;
  static const int fieldMinRespirationRate = 149;
  static const int fieldMinTemperature = 150;
  static const int fieldO2Toxicity = 155;
  static const int fieldDiveNumber = 156;
  static const int fieldTrainingLoadPeak = 168;
  static const int fieldEnhancedAvgRespirationRate = 169;
  static const int fieldEnhancedMaxRespirationRate = 170;
  static const int fieldEnhancedMinRespirationRate = 180;
  static const int fieldTotalGrit = 181;
  static const int fieldTotalFlow = 182;
  static const int fieldJumpCount = 183;
  static const int fieldAvgGrit = 186;
  static const int fieldAvgFlow = 187;
  static const int fieldWorkoutFeel = 192;
  static const int fieldWorkoutRpe = 193;
  static const int fieldAvgSpo2 = 194;
  static const int fieldAvgStress = 195;
  static const int fieldSdrrHrv = 197;
  static const int fieldRmssdHrv = 198;
  static const int fieldTotalFractionalAscent = 199;
  static const int fieldTotalFractionalDescent = 200;
  static const int fieldAvgCoreTemperature = 208;
  static const int fieldMinCoreTemperature = 209;
  static const int fieldMaxCoreTemperature = 210;
  static const int fieldActiveTime = 78;
  static const int fieldMetabolicCalories = 196;
  static const int fieldInvalid = Fit.fieldNumInvalid;

  SessionMesg() : super.from(Profile.getMesg(MesgNum.session));
  SessionMesg.fromMesg(super.mesg) : super.from();

  int? getMessageIndex() {
    final val = getFieldValue(
      254,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
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

  int? getEvent() {
    final val = getFieldValue(
      0,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEventType() {
    final val = getFieldValue(
      1,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  DateTime? getStartTime() {
    final val = getFieldValue(
      2,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            (val as int) * 1000 + 631065600000,
          );
  }

  int? getStartPositionLat() {
    final val = getFieldValue(
      3,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getStartPositionLong() {
    final val = getFieldValue(
      4,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSport() {
    final val = getFieldValue(
      5,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSubSport() {
    final val = getFieldValue(
      6,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTotalElapsedTime() {
    final val = getFieldValue(
      7,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalTimerTime() {
    final val = getFieldValue(
      8,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalDistance() {
    final val = getFieldValue(
      9,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getTotalCycles() {
    final val = getFieldValue(
      10,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getTotalStrides() {
    final val = getFieldValue(
      10,
      index: 0,
      subfieldInfo: SessionTotalCyclesSubfield.TotalStrides,
    );
    return val as int?;
  }

  int? getTotalStrokes() {
    final val = getFieldValue(
      10,
      index: 0,
      subfieldInfo: SessionTotalCyclesSubfield.TotalStrokes,
    );
    return val as int?;
  }

  int? getTotalCalories() {
    final val = getFieldValue(
      11,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getTotalFatCalories() {
    final val = getFieldValue(
      13,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgSpeed() {
    final val = getFieldValue(
      14,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxSpeed() {
    final val = getFieldValue(
      15,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgHeartRate() {
    final val = getFieldValue(
      16,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxHeartRate() {
    final val = getFieldValue(
      17,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgCadence() {
    final val = getFieldValue(
      18,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgRunningCadence() {
    final val = getFieldValue(
      18,
      index: 0,
      subfieldInfo: SessionAvgCadenceSubfield.AvgRunningCadence,
    );
    return val as int?;
  }

  int? getMaxCadence() {
    final val = getFieldValue(
      19,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxRunningCadence() {
    final val = getFieldValue(
      19,
      index: 0,
      subfieldInfo: SessionMaxCadenceSubfield.MaxRunningCadence,
    );
    return val as int?;
  }

  int? getAvgPower() {
    final val = getFieldValue(
      20,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxPower() {
    final val = getFieldValue(
      21,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getTotalAscent() {
    final val = getFieldValue(
      22,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getTotalDescent() {
    final val = getFieldValue(
      23,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTotalTrainingEffect() {
    final val = getFieldValue(
      24,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getFirstLapIndex() {
    final val = getFieldValue(
      25,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNumLaps() {
    final val = getFieldValue(
      26,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEventGroup() {
    final val = getFieldValue(
      27,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getTrigger() {
    final val = getFieldValue(
      28,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNecLat() {
    final val = getFieldValue(
      29,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNecLong() {
    final val = getFieldValue(
      30,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSwcLat() {
    final val = getFieldValue(
      31,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSwcLong() {
    final val = getFieldValue(
      32,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNumLengths() {
    final val = getFieldValue(
      33,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNormalizedPower() {
    final val = getFieldValue(
      34,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTrainingStressScore() {
    final val = getFieldValue(
      35,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getIntensityFactor() {
    final val = getFieldValue(
      36,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getLeftRightBalance() {
    final val = getFieldValue(
      37,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEndPositionLat() {
    final val = getFieldValue(
      38,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEndPositionLong() {
    final val = getFieldValue(
      39,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgStrokeCount() {
    final val = getFieldValue(
      41,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStrokeDistance() {
    final val = getFieldValue(
      42,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getSwimStroke() {
    final val = getFieldValue(
      43,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getPoolLength() {
    final val = getFieldValue(
      44,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getThresholdPower() {
    final val = getFieldValue(
      45,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getPoolLengthUnit() {
    final val = getFieldValue(
      46,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getNumActiveLengths() {
    final val = getFieldValue(
      47,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getTotalWork() {
    final val = getFieldValue(
      48,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgAltitude() {
    final val = getFieldValue(
      49,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxAltitude() {
    final val = getFieldValue(
      50,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getGpsAccuracy() {
    final val = getFieldValue(
      51,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgGrade() {
    final val = getFieldValue(
      52,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgPosGrade() {
    final val = getFieldValue(
      53,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgNegGrade() {
    final val = getFieldValue(
      54,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxPosGrade() {
    final val = getFieldValue(
      55,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxNegGrade() {
    final val = getFieldValue(
      56,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgTemperature() {
    final val = getFieldValue(
      57,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxTemperature() {
    final val = getFieldValue(
      58,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTotalMovingTime() {
    final val = getFieldValue(
      59,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgPosVerticalSpeed() {
    final val = getFieldValue(
      60,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgNegVerticalSpeed() {
    final val = getFieldValue(
      61,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxPosVerticalSpeed() {
    final val = getFieldValue(
      62,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxNegVerticalSpeed() {
    final val = getFieldValue(
      63,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getMinHeartRate() {
    final val = getFieldValue(
      64,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTimeInHrZone() {
    final val = getFieldValue(
      65,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTimeInSpeedZone() {
    final val = getFieldValue(
      66,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTimeInCadenceZone() {
    final val = getFieldValue(
      67,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTimeInPowerZone() {
    final val = getFieldValue(
      68,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgLapTime() {
    final val = getFieldValue(
      69,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getBestLapIndex() {
    final val = getFieldValue(
      70,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getMinAltitude() {
    final val = getFieldValue(
      71,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getPlayerScore() {
    final val = getFieldValue(
      82,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getOpponentScore() {
    final val = getFieldValue(
      83,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  String? getOpponentName() {
    final val = getFieldValue(
      84,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val?.toString();
  }

  int? getStrokeCount() {
    final val = getFieldValue(
      85,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getZoneCount() {
    final val = getFieldValue(
      86,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getMaxBallSpeed() {
    final val = getFieldValue(
      87,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgBallSpeed() {
    final val = getFieldValue(
      88,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgVerticalOscillation() {
    final val = getFieldValue(
      89,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStanceTimePercent() {
    final val = getFieldValue(
      90,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStanceTime() {
    final val = getFieldValue(
      91,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgFractionalCadence() {
    final val = getFieldValue(
      92,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxFractionalCadence() {
    final val = getFieldValue(
      93,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalFractionalCycles() {
    final val = getFieldValue(
      94,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgTotalHemoglobinConc() {
    final val = getFieldValue(
      95,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMinTotalHemoglobinConc() {
    final val = getFieldValue(
      96,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxTotalHemoglobinConc() {
    final val = getFieldValue(
      97,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgSaturatedHemoglobinPercent() {
    final val = getFieldValue(
      98,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMinSaturatedHemoglobinPercent() {
    final val = getFieldValue(
      99,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxSaturatedHemoglobinPercent() {
    final val = getFieldValue(
      100,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgLeftTorqueEffectiveness() {
    final val = getFieldValue(
      101,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightTorqueEffectiveness() {
    final val = getFieldValue(
      102,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgLeftPedalSmoothness() {
    final val = getFieldValue(
      103,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightPedalSmoothness() {
    final val = getFieldValue(
      104,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgCombinedPedalSmoothness() {
    final val = getFieldValue(
      105,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  String? getSportProfileName() {
    final val = getFieldValue(
      110,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val?.toString();
  }

  int? getSportIndex() {
    final val = getFieldValue(
      111,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTimeStanding() {
    final val = getFieldValue(
      112,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getStandCount() {
    final val = getFieldValue(
      113,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgLeftPco() {
    final val = getFieldValue(
      114,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgRightPco() {
    final val = getFieldValue(
      115,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgLeftPowerPhase() {
    final val = getFieldValue(
      116,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgLeftPowerPhasePeak() {
    final val = getFieldValue(
      117,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightPowerPhase() {
    final val = getFieldValue(
      118,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgRightPowerPhasePeak() {
    final val = getFieldValue(
      119,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgPowerPosition() {
    final val = getFieldValue(
      120,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxPowerPosition() {
    final val = getFieldValue(
      121,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgCadencePosition() {
    final val = getFieldValue(
      122,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxCadencePosition() {
    final val = getFieldValue(
      123,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getEnhancedAvgSpeed() {
    final val = getFieldValue(
      124,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getEnhancedMaxSpeed() {
    final val = getFieldValue(
      125,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getEnhancedAvgAltitude() {
    final val = getFieldValue(
      126,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getEnhancedMinAltitude() {
    final val = getFieldValue(
      127,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getEnhancedMaxAltitude() {
    final val = getFieldValue(
      128,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getAvgLevMotorPower() {
    final val = getFieldValue(
      129,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxLevMotorPower() {
    final val = getFieldValue(
      130,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getLevBatteryConsumption() {
    final val = getFieldValue(
      131,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgVerticalRatio() {
    final val = getFieldValue(
      132,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStanceTimeBalance() {
    final val = getFieldValue(
      133,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgStepLength() {
    final val = getFieldValue(
      134,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalAnaerobicTrainingEffect() {
    final val = getFieldValue(
      137,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgVam() {
    final val = getFieldValue(
      139,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgDepth() {
    final val = getFieldValue(
      140,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxDepth() {
    final val = getFieldValue(
      141,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getSurfaceInterval() {
    final val = getFieldValue(
      142,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getStartCns() {
    final val = getFieldValue(
      143,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEndCns() {
    final val = getFieldValue(
      144,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getStartN2() {
    final val = getFieldValue(
      145,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getEndN2() {
    final val = getFieldValue(
      146,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgRespirationRate() {
    final val = getFieldValue(
      147,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMaxRespirationRate() {
    final val = getFieldValue(
      148,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMinRespirationRate() {
    final val = getFieldValue(
      149,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getMinTemperature() {
    final val = getFieldValue(
      150,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getO2Toxicity() {
    final val = getFieldValue(
      155,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getDiveNumber() {
    final val = getFieldValue(
      156,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTrainingLoadPeak() {
    final val = getFieldValue(
      168,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getEnhancedAvgRespirationRate() {
    final val = getFieldValue(
      169,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getEnhancedMaxRespirationRate() {
    final val = getFieldValue(
      170,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getEnhancedMinRespirationRate() {
    final val = getFieldValue(
      180,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalGrit() {
    final val = getFieldValue(
      181,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalFlow() {
    final val = getFieldValue(
      182,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getJumpCount() {
    final val = getFieldValue(
      183,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getAvgGrit() {
    final val = getFieldValue(
      186,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgFlow() {
    final val = getFieldValue(
      187,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  int? getWorkoutFeel() {
    final val = getFieldValue(
      192,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getWorkoutRpe() {
    final val = getFieldValue(
      193,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgSpo2() {
    final val = getFieldValue(
      194,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getAvgStress() {
    final val = getFieldValue(
      195,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getSdrrHrv() {
    final val = getFieldValue(
      197,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  int? getRmssdHrv() {
    final val = getFieldValue(
      198,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }

  double? getTotalFractionalAscent() {
    final val = getFieldValue(
      199,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getTotalFractionalDescent() {
    final val = getFieldValue(
      200,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getAvgCoreTemperature() {
    final val = getFieldValue(
      208,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMinCoreTemperature() {
    final val = getFieldValue(
      209,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return (val as num?)?.toDouble();
  }

  double? getMaxCoreTemperature() {
    final val = getFieldValue(
      210,
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

  int? getMetabolicCalories() {
    final val = getFieldValue(
      196,
      index: 0,
      subfieldInfo: Fit.subfieldIndexMainField,
    );
    return val as int?;
  }
}
