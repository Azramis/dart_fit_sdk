import 'mesg.dart';
import 'field.dart';
import 'subfield.dart';
import 'field_component.dart';
import 'profile/types/mesg_num.dart';

enum ProfileType {
  enum_,
  sint8,
  uint8,
  sint16,
  uint16,
  sint32,
  uint32,
  string,
  float32,
  float64,
  uint8z,
  uint16z,
  uint32z,
  byte,
  sint64,
  uint64,
  uint64z,
  bool_,
  file,
  mesgNum,
  checksum,
  fileFlags,
  mesgCount,
  dateTime,
  localDateTime,
  messageIndex,
  deviceIndex,
  gender,
  language,
  languageBits0,
  languageBits1,
  languageBits2,
  languageBits3,
  languageBits4,
  timeZone,
  displayMeasure,
  displayHeart,
  displayPower,
  displayPosition,
  switch_,
  sport,
  sportBits0,
  sportBits1,
  sportBits2,
  sportBits3,
  sportBits4,
  sportBits5,
  sportBits6,
  subSport,
  sportEvent,
  activity,
  intensity,
  sessionTrigger,
  autolapTrigger,
  lapTrigger,
  timeMode,
  backlightMode,
  dateMode,
  backlightTimeout,
  event,
  eventType,
  timerTrigger,
  fitnessEquipmentState,
  tone,
  autoscroll,
  activityClass,
  hrZoneCalc,
  pwrZoneCalc,
  wktStepDuration,
  wktStepTarget,
  goal,
  goalRecurrence,
  goalSource,
  schedule,
  coursePoint,
  manufacturer,
  garminProduct,
  antplusDeviceType,
  antNetwork,
  workoutCapabilities,
  batteryStatus,
  hrType,
  courseCapabilities,
  weight,
  workoutHr,
  workoutPower,
  bpStatus,
  userLocalId,
  swimStroke,
  activityType,
  activitySubtype,
  activityLevel,
  side,
  leftRightBalance,
  leftRightBalance100,
  lengthType,
  dayOfWeek,
  connectivityCapabilities,
  weatherReport,
  weatherStatus,
  weatherSeverity,
  weatherSevereType,
  timeIntoDay,
  localtimeIntoDay,
  strokeType,
  bodyLocation,
  segmentLapStatus,
  segmentLeaderboardType,
  segmentDeleteStatus,
  segmentSelectionType,
  sourceType,
  localDeviceType,
  bleDeviceType,
  antChannelId,
  displayOrientation,
  workoutEquipment,
  watchfaceMode,
  digitalWatchfaceLayout,
  analogWatchfaceLayout,
  riderPositionType,
  powerPhaseType,
  cameraEventType,
  sensorType,
  bikeLightNetworkConfigType,
  commTimeoutType,
  cameraOrientationType,
  attitudeStage,
  attitudeValidity,
  autoSyncFrequency,
  exdLayout,
  exdDisplayType,
  exdDataUnits,
  exdQualifiers,
  exdDescriptors,
  autoActivityDetect,
  supportedExdScreenLayouts,
  fitBaseType,
  turnType,
  bikeLightBeamAngleMode,
  fitBaseUnit,
  setType,
  maxMetCategory,
  exerciseCategory,
  benchPressExerciseName,
  calfRaiseExerciseName,
  cardioExerciseName,
  carryExerciseName,
  chopExerciseName,
  coreExerciseName,
  crunchExerciseName,
  curlExerciseName,
  deadliftExerciseName,
  flyeExerciseName,
  hipRaiseExerciseName,
  hipStabilityExerciseName,
  hipSwingExerciseName,
  hyperextensionExerciseName,
  lateralRaiseExerciseName,
  legCurlExerciseName,
  legRaiseExerciseName,
  lungeExerciseName,
  olympicLiftExerciseName,
  plankExerciseName,
  plyoExerciseName,
  pullUpExerciseName,
  pushUpExerciseName,
  rowExerciseName,
  shoulderPressExerciseName,
  shoulderStabilityExerciseName,
  shrugExerciseName,
  sitUpExerciseName,
  squatExerciseName,
  totalBodyExerciseName,
  moveExerciseName,
  poseExerciseName,
  tricepsExtensionExerciseName,
  warmUpExerciseName,
  runExerciseName,
  bikeExerciseName,
  bandedExercisesExerciseName,
  battleRopeExerciseName,
  ellipticalExerciseName,
  floorClimbExerciseName,
  indoorBikeExerciseName,
  indoorRowExerciseName,
  ladderExerciseName,
  sandbagExerciseName,
  sledExerciseName,
  sledgeHammerExerciseName,
  stairStepperExerciseName,
  suspensionExerciseName,
  tireExerciseName,
  bikeOutdoorExerciseName,
  runIndoorExerciseName,
  waterType,
  tissueModelType,
  diveGasStatus,
  diveAlert,
  diveAlarmType,
  diveBacklightMode,
  sleepLevel,
  spo2MeasurementType,
  ccrSetpointSwitchMode,
  diveGasMode,
  projectileType,
  faveroProduct,
  splitType,
  climbProEvent,
  gasConsumptionRateType,
  tapSensitivity,
  radarThreatLevelType,
  sleepDisruptionSeverity,
  maxMetSpeedSource,
  maxMetHeartRateSource,
  hrvStatus,
  noFlyTimeMode,

  numTypes,
  napPeriodFeedback,
  napSource,
}

class Profile {
  static final Map<int, Mesg> m_mesgLookup = {};

  static Mesg getMesg(int globalMesgNum) {
    final Mesg? mesg = lookupMesg(globalMesgNum);

    if (null != mesg) {
      return mesg;
    }

    return Mesg("unknown", globalMesgNum);
  }

  static Field getField(int globalMesgNum, int fieldNum) {
    final Mesg? mesg = lookupMesg(globalMesgNum);

    if (null != mesg) {
      return mesg.getField(fieldNum) ??
          Field("unknown", fieldNum, 0, 1.0, 0.0, "", false, ProfileType.enum_);
    }

    return Field(
      "unknown",
      fieldNum,
      0,
      1.0,
      0.0,
      "",
      false,
      ProfileType.enum_,
    );
  }

  static Field? getFieldByName(int globalMesgNum, String fieldName) {
    final Mesg? mesg = lookupMesg(globalMesgNum);

    if (null != mesg) {
      return mesg.getFieldByName(fieldName);
    }

    return null;
  }

  static Mesg? lookupMesg(int globalMesgNum) {
    if (!m_mesgLookup.containsKey(globalMesgNum)) {
      initMesg(globalMesgNum);
    }

    return m_mesgLookup[globalMesgNum];
  }

  static void initMesg(int num) {
    if (m_mesgLookup.containsKey(num)) {
      return;
    }

    Mesg? newMesg;
    switch (num) {
      case MesgNum.fileId:
        newMesg = createFileIdMesg();
        break;
      case MesgNum.fileCreator:
        newMesg = createFileCreatorMesg();
        break;
      case MesgNum.timestampCorrelation:
        newMesg = createTimestampCorrelationMesg();
        break;
      case MesgNum.software:
        newMesg = createSoftwareMesg();
        break;
      case MesgNum.slaveDevice:
        newMesg = createSlaveDeviceMesg();
        break;
      case MesgNum.capabilities:
        newMesg = createCapabilitiesMesg();
        break;
      case MesgNum.fileCapabilities:
        newMesg = createFileCapabilitiesMesg();
        break;
      case MesgNum.mesgCapabilities:
        newMesg = createMesgCapabilitiesMesg();
        break;
      case MesgNum.fieldCapabilities:
        newMesg = createFieldCapabilitiesMesg();
        break;
      case MesgNum.deviceSettings:
        newMesg = createDeviceSettingsMesg();
        break;
      case MesgNum.userProfile:
        newMesg = createUserProfileMesg();
        break;
      case MesgNum.hrmProfile:
        newMesg = createHrmProfileMesg();
        break;
      case MesgNum.sdmProfile:
        newMesg = createSdmProfileMesg();
        break;
      case MesgNum.bikeProfile:
        newMesg = createBikeProfileMesg();
        break;
      case MesgNum.connectivity:
        newMesg = createConnectivityMesg();
        break;
      case MesgNum.watchfaceSettings:
        newMesg = createWatchfaceSettingsMesg();
        break;
      case MesgNum.ohrSettings:
        newMesg = createOhrSettingsMesg();
        break;
      case MesgNum.timeInZone:
        newMesg = createTimeInZoneMesg();
        break;
      case MesgNum.zonesTarget:
        newMesg = createZonesTargetMesg();
        break;
      case MesgNum.sport:
        newMesg = createSportMesg();
        break;
      case MesgNum.hrZone:
        newMesg = createHrZoneMesg();
        break;
      case MesgNum.speedZone:
        newMesg = createSpeedZoneMesg();
        break;
      case MesgNum.cadenceZone:
        newMesg = createCadenceZoneMesg();
        break;
      case MesgNum.powerZone:
        newMesg = createPowerZoneMesg();
        break;
      case MesgNum.metZone:
        newMesg = createMetZoneMesg();
        break;
      case MesgNum.trainingSettings:
        newMesg = createTrainingSettingsMesg();
        break;
      case MesgNum.diveSettings:
        newMesg = createDiveSettingsMesg();
        break;
      case MesgNum.diveAlarm:
        newMesg = createDiveAlarmMesg();
        break;
      case MesgNum.diveApneaAlarm:
        newMesg = createDiveApneaAlarmMesg();
        break;
      case MesgNum.diveGas:
        newMesg = createDiveGasMesg();
        break;
      case MesgNum.goal:
        newMesg = createGoalMesg();
        break;
      case MesgNum.activity:
        newMesg = createActivityMesg();
        break;
      case MesgNum.session:
        newMesg = createSessionMesg();
        break;
      case MesgNum.lap:
        newMesg = createLapMesg();
        break;
      case MesgNum.length:
        newMesg = createLengthMesg();
        break;
      case MesgNum.record:
        newMesg = createRecordMesg();
        break;
      case MesgNum.event:
        newMesg = createEventMesg();
        break;
      case MesgNum.deviceInfo:
        newMesg = createDeviceInfoMesg();
        break;
      case MesgNum.deviceAuxBatteryInfo:
        newMesg = createDeviceAuxBatteryInfoMesg();
        break;
      case MesgNum.trainingFile:
        newMesg = createTrainingFileMesg();
        break;
      case MesgNum.weatherConditions:
        newMesg = createWeatherConditionsMesg();
        break;
      case MesgNum.weatherAlert:
        newMesg = createWeatherAlertMesg();
        break;
      case MesgNum.gpsMetadata:
        newMesg = createGpsMetadataMesg();
        break;
      case MesgNum.cameraEvent:
        newMesg = createCameraEventMesg();
        break;
      case MesgNum.gyroscopeData:
        newMesg = createGyroscopeDataMesg();
        break;
      case MesgNum.accelerometerData:
        newMesg = createAccelerometerDataMesg();
        break;
      case MesgNum.magnetometerData:
        newMesg = createMagnetometerDataMesg();
        break;
      case MesgNum.barometerData:
        newMesg = createBarometerDataMesg();
        break;
      case MesgNum.threeDSensorCalibration:
        newMesg = createThreeDSensorCalibrationMesg();
        break;
      case MesgNum.oneDSensorCalibration:
        newMesg = createOneDSensorCalibrationMesg();
        break;
      case MesgNum.videoFrame:
        newMesg = createVideoFrameMesg();
        break;
      case MesgNum.obdiiData:
        newMesg = createObdiiDataMesg();
        break;
      case MesgNum.nmeaSentence:
        newMesg = createNmeaSentenceMesg();
        break;
      case MesgNum.aviationAttitude:
        newMesg = createAviationAttitudeMesg();
        break;
      case MesgNum.video:
        newMesg = createVideoMesg();
        break;
      case MesgNum.videoTitle:
        newMesg = createVideoTitleMesg();
        break;
      case MesgNum.videoDescription:
        newMesg = createVideoDescriptionMesg();
        break;
      case MesgNum.videoClip:
        newMesg = createVideoClipMesg();
        break;
      case MesgNum.set_:
        newMesg = createSetMesg();
        break;
      case MesgNum.jump:
        newMesg = createJumpMesg();
        break;
      case MesgNum.split:
        newMesg = createSplitMesg();
        break;
      case MesgNum.splitSummary:
        newMesg = createSplitSummaryMesg();
        break;
      case MesgNum.climbPro:
        newMesg = createClimbProMesg();
        break;
      case MesgNum.fieldDescription:
        newMesg = createFieldDescriptionMesg();
        break;
      case MesgNum.developerDataId:
        newMesg = createDeveloperDataIdMesg();
        break;
      case MesgNum.course:
        newMesg = createCourseMesg();
        break;
      case MesgNum.coursePoint:
        newMesg = createCoursePointMesg();
        break;
      case MesgNum.segmentId:
        newMesg = createSegmentIdMesg();
        break;
      case MesgNum.segmentLeaderboardEntry:
        newMesg = createSegmentLeaderboardEntryMesg();
        break;
      case MesgNum.segmentPoint:
        newMesg = createSegmentPointMesg();
        break;
      case MesgNum.segmentLap:
        newMesg = createSegmentLapMesg();
        break;
      case MesgNum.segmentFile:
        newMesg = createSegmentFileMesg();
        break;
      case MesgNum.workout:
        newMesg = createWorkoutMesg();
        break;
      case MesgNum.workoutSession:
        newMesg = createWorkoutSessionMesg();
        break;
      case MesgNum.workoutStep:
        newMesg = createWorkoutStepMesg();
        break;
      case MesgNum.exerciseTitle:
        newMesg = createExerciseTitleMesg();
        break;
      case MesgNum.schedule:
        newMesg = createScheduleMesg();
        break;
      case MesgNum.totals:
        newMesg = createTotalsMesg();
        break;
      case MesgNum.weightScale:
        newMesg = createWeightScaleMesg();
        break;
      case MesgNum.bloodPressure:
        newMesg = createBloodPressureMesg();
        break;
      case MesgNum.monitoringInfo:
        newMesg = createMonitoringInfoMesg();
        break;
      case MesgNum.monitoring:
        newMesg = createMonitoringMesg();
        break;
      case MesgNum.monitoringHrData:
        newMesg = createMonitoringHrDataMesg();
        break;
      case MesgNum.spo2Data:
        newMesg = createSpo2DataMesg();
        break;
      case MesgNum.hr:
        newMesg = createHrMesg();
        break;
      case MesgNum.stressLevel:
        newMesg = createStressLevelMesg();
        break;
      case MesgNum.maxMetData:
        newMesg = createMaxMetDataMesg();
        break;
      case MesgNum.hsaBodyBatteryData:
        newMesg = createHsaBodyBatteryDataMesg();
        break;
      case MesgNum.hsaEvent:
        newMesg = createHsaEventMesg();
        break;
      case MesgNum.hsaAccelerometerData:
        newMesg = createHsaAccelerometerDataMesg();
        break;
      case MesgNum.hsaGyroscopeData:
        newMesg = createHsaGyroscopeDataMesg();
        break;
      case MesgNum.hsaStepData:
        newMesg = createHsaStepDataMesg();
        break;
      case MesgNum.hsaSpo2Data:
        newMesg = createHsaSpo2DataMesg();
        break;
      case MesgNum.hsaStressData:
        newMesg = createHsaStressDataMesg();
        break;
      case MesgNum.hsaRespirationData:
        newMesg = createHsaRespirationDataMesg();
        break;
      case MesgNum.hsaHeartRateData:
        newMesg = createHsaHeartRateDataMesg();
        break;
      case MesgNum.hsaConfigurationData:
        newMesg = createHsaConfigurationDataMesg();
        break;
      case MesgNum.hsaWristTemperatureData:
        newMesg = createHsaWristTemperatureDataMesg();
        break;
      case MesgNum.memoGlob:
        newMesg = createMemoGlobMesg();
        break;
      case MesgNum.sleepLevel:
        newMesg = createSleepLevelMesg();
        break;
      case MesgNum.antChannelId:
        newMesg = createAntChannelIdMesg();
        break;
      case MesgNum.antRx:
        newMesg = createAntRxMesg();
        break;
      case MesgNum.antTx:
        newMesg = createAntTxMesg();
        break;
      case MesgNum.exdScreenConfiguration:
        newMesg = createExdScreenConfigurationMesg();
        break;
      case MesgNum.exdDataFieldConfiguration:
        newMesg = createExdDataFieldConfigurationMesg();
        break;
      case MesgNum.exdDataConceptConfiguration:
        newMesg = createExdDataConceptConfigurationMesg();
        break;
      case MesgNum.diveSummary:
        newMesg = createDiveSummaryMesg();
        break;
      case MesgNum.aadAccelFeatures:
        newMesg = createAadAccelFeaturesMesg();
        break;
      case MesgNum.hrv:
        newMesg = createHrvMesg();
        break;
      case MesgNum.beatIntervals:
        newMesg = createBeatIntervalsMesg();
        break;
      case MesgNum.hrvStatusSummary:
        newMesg = createHrvStatusSummaryMesg();
        break;
      case MesgNum.hrvValue:
        newMesg = createHrvValueMesg();
        break;
      case MesgNum.rawBbi:
        newMesg = createRawBbiMesg();
        break;
      case MesgNum.respirationRate:
        newMesg = createRespirationRateMesg();
        break;
      case MesgNum.chronoShotSession:
        newMesg = createChronoShotSessionMesg();
        break;
      case MesgNum.chronoShotData:
        newMesg = createChronoShotDataMesg();
        break;
      case MesgNum.tankUpdate:
        newMesg = createTankUpdateMesg();
        break;
      case MesgNum.tankSummary:
        newMesg = createTankSummaryMesg();
        break;
      case MesgNum.sleepAssessment:
        newMesg = createSleepAssessmentMesg();
        break;
      case MesgNum.sleepDisruptionSeverityPeriod:
        newMesg = createSleepDisruptionSeverityPeriodMesg();
        break;
      case MesgNum.sleepDisruptionOvernightSeverity:
        newMesg = createSleepDisruptionOvernightSeverityMesg();
        break;
      case MesgNum.skinTempOvernight:
        newMesg = createSkinTempOvernightMesg();
        break;
      case MesgNum.pad:
        newMesg = createPadMesg();
        break;
      case MesgNum.napEvent:
        newMesg = createNapEventMesg();
        break;
      default:
        break;
    }

    if (null != newMesg) {
      m_mesgLookup[num] = newMesg;
    }
  }

  static Mesg createFileIdMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("FileId", MesgNum.fileId);
    fieldIndex = 0;
    newMesg.setField(
      Field("Type", 0, 0, 1.0, 0.0, "", false, ProfileType.file),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Manufacturer",
        1,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.manufacturer,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Product", 2, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    subfieldIndex = 0;
    newMesg.fields[fieldIndex].subfields.add(
      Subfield("FaveroProduct", 132, 1.0, 0.0, ""),
    );
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(1, 263);
    subfieldIndex++;
    newMesg.fields[fieldIndex].subfields.add(
      Subfield("GarminProduct", 132, 1.0, 0.0, ""),
    );
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(1, 1);
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(1, 15);
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(1, 13);
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(1, 89);
    subfieldIndex++;
    fieldIndex++;
    newMesg.setField(
      Field("SerialNumber", 3, 140, 1.0, 0.0, "", false, ProfileType.uint32z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeCreated", 4, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Number", 5, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ProductName", 8, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createFileCreatorMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("FileCreator", MesgNum.fileCreator);
    fieldIndex = 0;
    newMesg.setField(
      Field("SoftwareVersion", 0, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HardwareVersion", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createTimestampCorrelationMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "TimestampCorrelation",
      MesgNum.timestampCorrelation,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FractionalTimestamp",
        0,
        132,
        32768.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SystemTimestamp",
        1,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.dateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FractionalSystemTimestamp",
        2,
        132,
        32768.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LocalTimestamp",
        3,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.localDateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 4, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SystemTimestampMs",
        5,
        132,
        1.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSoftwareMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Software", MesgNum.software);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Version", 3, 132, 100.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PartNumber", 5, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSlaveDeviceMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SlaveDevice", MesgNum.slaveDevice);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "Manufacturer",
        0,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.manufacturer,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Product", 1, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    subfieldIndex = 0;
    newMesg.fields[fieldIndex].subfields.add(
      Subfield("FaveroProduct", 132, 1.0, 0.0, ""),
    );
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(0, 263);
    subfieldIndex++;
    newMesg.fields[fieldIndex].subfields.add(
      Subfield("GarminProduct", 132, 1.0, 0.0, ""),
    );
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(0, 1);
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(0, 15);
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(0, 13);
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(0, 89);
    subfieldIndex++;
    fieldIndex++;

    return newMesg;
  }

  static Mesg createCapabilitiesMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Capabilities", MesgNum.capabilities);
    fieldIndex = 0;
    newMesg.setField(
      Field("Languages", 0, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sports", 1, 10, 1.0, 0.0, "", false, ProfileType.sportBits0),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WorkoutsSupported",
        21,
        140,
        1.0,
        0.0,
        "",
        false,
        ProfileType.workoutCapabilities,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ConnectivitySupported",
        23,
        140,
        1.0,
        0.0,
        "",
        false,
        ProfileType.connectivityCapabilities,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createFileCapabilitiesMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("FileCapabilities", MesgNum.fileCapabilities);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Type", 0, 0, 1.0, 0.0, "", false, ProfileType.file),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Flags", 1, 10, 1.0, 0.0, "", false, ProfileType.fileFlags),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Directory", 2, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxCount", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxSize", 4, 134, 1.0, 0.0, "bytes", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMesgCapabilitiesMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("MesgCapabilities", MesgNum.mesgCapabilities);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("File", 0, 0, 1.0, 0.0, "", false, ProfileType.file),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MesgNum", 1, 132, 1.0, 0.0, "", false, ProfileType.mesgNum),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CountType", 2, 0, 1.0, 0.0, "", false, ProfileType.mesgCount),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Count", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    subfieldIndex = 0;
    newMesg.fields[fieldIndex].subfields.add(
      Subfield("NumPerFile", 132, 1.0, 0.0, ""),
    );
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(2, 0);
    subfieldIndex++;
    newMesg.fields[fieldIndex].subfields.add(
      Subfield("MaxPerFile", 132, 1.0, 0.0, ""),
    );
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(2, 1);
    subfieldIndex++;
    newMesg.fields[fieldIndex].subfields.add(
      Subfield("MaxPerFileType", 132, 1.0, 0.0, ""),
    );
    newMesg.fields[fieldIndex].subfields[subfieldIndex].addMap(2, 2);
    subfieldIndex++;
    fieldIndex++;

    return newMesg;
  }

  static Mesg createFieldCapabilitiesMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("FieldCapabilities", MesgNum.fieldCapabilities);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("File", 0, 0, 1.0, 0.0, "", false, ProfileType.file),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MesgNum", 1, 132, 1.0, 0.0, "", false, ProfileType.mesgNum),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FieldNum", 2, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Count", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDeviceSettingsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DeviceSettings", MesgNum.deviceSettings);
    fieldIndex = 0;
    newMesg.setField(
      Field("ActiveTimeZone", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("UtcOffset", 1, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeOffset", 2, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeMode", 4, 0, 1.0, 0.0, "", false, ProfileType.timeMode),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeZoneOffset", 5, 1, 4.0, 0.0, "hr", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BacklightMode",
        12,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.backlightMode,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityTrackerEnabled",
        36,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ClockTime", 39, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PagesEnabled", 40, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MoveAlertEnabled", 46, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DateMode", 47, 0, 1.0, 0.0, "", false, ProfileType.dateMode),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DisplayOrientation",
        55,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayOrientation,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MountingSide", 56, 0, 1.0, 0.0, "", false, ProfileType.side),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DefaultPage", 57, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AutosyncMinSteps",
        58,
        132,
        1.0,
        0.0,
        "steps",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AutosyncMinTime",
        59,
        132,
        1.0,
        0.0,
        "minutes",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LactateThresholdAutodetectEnabled",
        80,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BleAutoUploadEnabled",
        86,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AutoSyncFrequency",
        89,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.autoSyncFrequency,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AutoActivityDetect",
        90,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.autoActivityDetect,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NumberOfScreens", 94, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SmartNotificationDisplayOrientation",
        95,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayOrientation,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TapInterface", 134, 0, 1.0, 0.0, "", false, ProfileType.switch_),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TapSensitivity",
        174,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.tapSensitivity,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createUserProfileMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("UserProfile", MesgNum.userProfile);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FriendlyName", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Gender", 1, 0, 1.0, 0.0, "", false, ProfileType.gender),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Age", 2, 2, 1.0, 0.0, "years", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Height", 3, 2, 100.0, 0.0, "m", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Weight", 4, 132, 10.0, 0.0, "kg", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Language", 5, 0, 1.0, 0.0, "", false, ProfileType.language),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ElevSetting",
        6,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WeightSetting",
        7,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RestingHeartRate",
        8,
        2,
        1.0,
        0.0,
        "bpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DefaultMaxRunningHeartRate",
        9,
        2,
        1.0,
        0.0,
        "bpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DefaultMaxBikingHeartRate",
        10,
        2,
        1.0,
        0.0,
        "bpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DefaultMaxHeartRate",
        11,
        2,
        1.0,
        0.0,
        "bpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HrSetting", 12, 0, 1.0, 0.0, "", false, ProfileType.displayHeart),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SpeedSetting",
        13,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DistSetting",
        14,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PowerSetting",
        16,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayPower,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityClass",
        17,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.activityClass,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionSetting",
        18,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayPosition,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TemperatureSetting",
        21,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LocalId", 22, 132, 1.0, 0.0, "", false, ProfileType.userLocalId),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GlobalId", 23, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WakeTime",
        28,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.localtimeIntoDay,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SleepTime",
        29,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.localtimeIntoDay,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "HeightSetting",
        30,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "UserRunningStepLength",
        31,
        132,
        1000.0,
        0.0,
        "m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "UserWalkingStepLength",
        32,
        132,
        1000.0,
        0.0,
        "m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DepthSetting",
        47,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DiveCount", 49, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHrmProfileMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HrmProfile", MesgNum.hrmProfile);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 0, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HrmAntId", 1, 139, 1.0, 0.0, "", false, ProfileType.uint16z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LogHrv", 2, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "HrmAntIdTransType",
        3,
        10,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8z,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSdmProfileMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SdmProfile", MesgNum.sdmProfile);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 0, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SdmAntId", 1, 139, 1.0, 0.0, "", false, ProfileType.uint16z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SdmCalFactor", 2, 132, 10.0, 0.0, "%", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Odometer", 3, 134, 100.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SpeedSource", 4, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SdmAntIdTransType",
        5,
        10,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OdometerRollover", 7, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createBikeProfileMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("BikeProfile", MesgNum.bikeProfile);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 1, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 2, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Odometer", 3, 134, 100.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BikeSpdAntId", 4, 139, 1.0, 0.0, "", false, ProfileType.uint16z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BikeCadAntId", 5, 139, 1.0, 0.0, "", false, ProfileType.uint16z),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BikeSpdcadAntId",
        6,
        139,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BikePowerAntId", 7, 139, 1.0, 0.0, "", false, ProfileType.uint16z),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CustomWheelsize",
        8,
        132,
        1000.0,
        0.0,
        "m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AutoWheelsize",
        9,
        132,
        1000.0,
        0.0,
        "m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BikeWeight", 10, 132, 10.0, 0.0, "kg", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PowerCalFactor",
        11,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AutoWheelCal", 12, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AutoPowerZero", 13, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Id", 14, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SpdEnabled", 15, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CadEnabled", 16, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SpdcadEnabled", 17, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PowerEnabled", 18, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CrankLength", 19, 2, 2.0, -110.0, "mm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 20, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BikeSpdAntIdTransType",
        21,
        10,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BikeCadAntIdTransType",
        22,
        10,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BikeSpdcadAntIdTransType",
        23,
        10,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BikePowerAntIdTransType",
        24,
        10,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OdometerRollover", 37, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FrontGearNum", 38, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FrontGear", 39, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RearGearNum", 40, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RearGear", 41, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ShimanoDi2Enabled", 44, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createConnectivityMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Connectivity", MesgNum.connectivity);
    fieldIndex = 0;
    newMesg.setField(
      Field("BluetoothEnabled", 0, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BluetoothLeEnabled", 1, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AntEnabled", 2, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 3, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LiveTrackingEnabled",
        4,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WeatherConditionsEnabled",
        5,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WeatherAlertsEnabled",
        6,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AutoActivityUploadEnabled",
        7,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CourseDownloadEnabled",
        8,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WorkoutDownloadEnabled",
        9,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "GpsEphemerisDownloadEnabled",
        10,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "IncidentDetectionEnabled",
        11,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GrouptrackEnabled", 12, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createWatchfaceSettingsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("WatchfaceSettings", MesgNum.watchfaceSettings);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Mode", 0, 0, 1.0, 0.0, "", false, ProfileType.watchfaceMode),
    );
    fieldIndex++;
    Field field;
    field = Field("Layout", 1, 13, 1.0, 0.0, "", false, ProfileType.byte);
    subfieldIndex = 0;
    field.subfields.add(Subfield("DigitalLayout", 0, 1.0, 0.0, ""));
    field.subfields[subfieldIndex].addMap(0, 0);
    subfieldIndex++;
    field.subfields.add(Subfield("AnalogLayout", 0, 1.0, 0.0, ""));
    field.subfields[subfieldIndex].addMap(0, 1);
    subfieldIndex++;
    newMesg.setField(field);
    fieldIndex++;

    return newMesg;
  }

  static Mesg createOhrSettingsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("OhrSettings", MesgNum.ohrSettings);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 0, 0, 1.0, 0.0, "", false, ProfileType.switch_),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createTimeInZoneMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("TimeInZone", MesgNum.timeInZone);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ReferenceMesg", 0, 132, 1.0, 0.0, "", false, ProfileType.mesgNum),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ReferenceIndex",
        1,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInHrZone",
        2,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInSpeedZone",
        3,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInCadenceZone",
        4,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInPowerZone",
        5,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "HrZoneHighBoundary",
        6,
        2,
        1.0,
        0.0,
        "bpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SpeedZoneHighBoundary",
        7,
        132,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CadenceZoneHighBondary",
        8,
        2,
        1.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PowerZoneHighBoundary",
        9,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HrCalcType", 10, 0, 1.0, 0.0, "", false, ProfileType.hrZoneCalc),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxHeartRate", 11, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RestingHeartRate", 12, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ThresholdHeartRate",
        13,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PwrCalcType", 14, 0, 1.0, 0.0, "", false, ProfileType.pwrZoneCalc),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FunctionalThresholdPower",
        15,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createZonesTargetMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("ZonesTarget", MesgNum.zonesTarget);
    fieldIndex = 0;
    newMesg.setField(
      Field("MaxHeartRate", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ThresholdHeartRate", 2, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FunctionalThresholdPower",
        3,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HrCalcType", 5, 0, 1.0, 0.0, "", false, ProfileType.hrZoneCalc),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PwrCalcType", 7, 0, 1.0, 0.0, "", false, ProfileType.pwrZoneCalc),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSportMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Sport", MesgNum.sport);
    fieldIndex = 0;
    newMesg.setField(
      Field("Sport", 0, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 1, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 3, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHrZoneMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HrZone", MesgNum.hrZone);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HighBpm", 1, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 2, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSpeedZoneMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SpeedZone", MesgNum.speedZone);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HighValue", 0, 132, 1000.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createCadenceZoneMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("CadenceZone", MesgNum.cadenceZone);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HighValue", 0, 2, 1.0, 0.0, "rpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createPowerZoneMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("PowerZone", MesgNum.powerZone);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HighValue", 1, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 2, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMetZoneMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("MetZone", MesgNum.metZone);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HighBpm", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Calories",
        2,
        132,
        10.0,
        0.0,
        "kcal / min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FatCalories",
        3,
        2,
        10.0,
        0.0,
        "kcal / min",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createTrainingSettingsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("TrainingSettings", MesgNum.trainingSettings);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "TargetDistance",
        31,
        134,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TargetSpeed",
        32,
        132,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TargetTime", 33, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PreciseTargetSpeed",
        153,
        134,
        1000000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDiveSettingsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DiveSettings", MesgNum.diveSettings);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Model", 1, 0, 1.0, 0.0, "", false, ProfileType.tissueModelType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GfLow", 2, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GfHigh", 3, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WaterType", 4, 0, 1.0, 0.0, "", false, ProfileType.waterType),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WaterDensity",
        5,
        136,
        1.0,
        0.0,
        "kg/m^3",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Po2Warn", 6, 2, 100.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Po2Critical",
        7,
        2,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Po2Deco", 8, 2, 100.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SafetyStopEnabled", 9, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BottomDepth", 10, 136, 1.0, 0.0, "", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BottomTime", 11, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ApneaCountdownEnabled",
        12,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bool_,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ApneaCountdownTime",
        13,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BacklightMode",
        14,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.diveBacklightMode,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BacklightBrightness",
        15,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BacklightTimeout",
        16,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.backlightTimeout,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RepeatDiveInterval",
        17,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SafetyStopTime",
        18,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "HeartRateSourceType",
        19,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.sourceType,
      ),
    );
    fieldIndex++;
    final Field heartRateSourceField = Field(
      "HeartRateSource",
      20,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    subfieldIndex = 0;
    heartRateSourceField.subfields.add(
      Subfield("HeartRateAntplusDeviceType", 2, 1.0, 0.0, ""),
    );
    heartRateSourceField.subfields[subfieldIndex].addMap(19, 1);
    subfieldIndex++;
    heartRateSourceField.subfields.add(
      Subfield("HeartRateLocalDeviceType", 2, 1.0, 0.0, ""),
    );
    heartRateSourceField.subfields[subfieldIndex].addMap(19, 5);
    subfieldIndex++;
    newMesg.setField(heartRateSourceField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "TravelGas",
        21,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CcrLowSetpointSwitchMode",
        22,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.ccrSetpointSwitchMode,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CcrLowSetpoint",
        23,
        2,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CcrLowSetpointDepth",
        24,
        134,
        1000.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CcrHighSetpointSwitchMode",
        25,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.ccrSetpointSwitchMode,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CcrHighSetpoint",
        26,
        2,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CcrHighSetpointDepth",
        27,
        134,
        1000.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "GasConsumptionDisplay",
        29,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.gasConsumptionRateType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("UpKeyEnabled", 30, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DiveSounds", 35, 0, 1.0, 0.0, "", false, ProfileType.tone),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LastStopMultiple", 36, 2, 10.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NoFlyTimeMode",
        37,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.noFlyTimeMode,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDiveAlarmMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DiveAlarm", MesgNum.diveAlarm);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Depth", 0, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Time", 1, 133, 1.0, 0.0, "s", false, ProfileType.sint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 2, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AlarmType", 3, 0, 1.0, 0.0, "", false, ProfileType.diveAlarmType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sound", 4, 0, 1.0, 0.0, "", false, ProfileType.tone),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DiveTypes", 5, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Id", 6, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PopupEnabled", 7, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TriggerOnDescent", 8, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TriggerOnAscent", 9, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Repeating", 10, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Speed", 11, 133, 1000.0, 0.0, "mps", false, ProfileType.sint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDiveApneaAlarmMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DiveApneaAlarm", MesgNum.diveApneaAlarm);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Depth", 0, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Time", 1, 133, 1.0, 0.0, "s", false, ProfileType.sint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 2, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AlarmType", 3, 0, 1.0, 0.0, "", false, ProfileType.diveAlarmType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sound", 4, 0, 1.0, 0.0, "", false, ProfileType.tone),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DiveTypes", 5, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Id", 6, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PopupEnabled", 7, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TriggerOnDescent", 8, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TriggerOnAscent", 9, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Repeating", 10, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Speed", 11, 133, 1000.0, 0.0, "mps", false, ProfileType.sint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDiveGasMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DiveGas", MesgNum.diveGas);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "HeliumContent",
        0,
        2,
        1.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "OxygenContent",
        1,
        2,
        1.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Status", 2, 0, 1.0, 0.0, "", false, ProfileType.diveGasStatus),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Mode", 3, 0, 1.0, 0.0, "", false, ProfileType.diveGasMode),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createGoalMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Goal", MesgNum.goal);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 0, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 1, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartDate", 2, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndDate", 3, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Type", 4, 0, 1.0, 0.0, "", false, ProfileType.goal),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Value", 5, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Repeat", 6, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TargetValue", 7, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Recurrence",
        8,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.goalRecurrence,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RecurrenceValue", 9, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 10, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Source", 11, 0, 1.0, 0.0, "", false, ProfileType.goalSource),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createActivityMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Activity", MesgNum.activity);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTimerTime",
        0,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NumSessions", 1, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Type", 2, 0, 1.0, 0.0, "", false, ProfileType.activity),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Event", 3, 0, 1.0, 0.0, "", false, ProfileType.event),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventType", 4, 0, 1.0, 0.0, "", false, ProfileType.eventType),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LocalTimestamp",
        5,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.localDateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventGroup", 6, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSessionMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Session", MesgNum.session);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Event", 0, 0, 1.0, 0.0, "", false, ProfileType.event),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventType", 1, 0, 1.0, 0.0, "", false, ProfileType.eventType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartTime", 2, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLat",
        3,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLong",
        4,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 5, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 6, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalElapsedTime",
        7,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTimerTime",
        8,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalDistance",
        9,
        134,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    final Field totalCyclesField = Field(
      "TotalCycles",
      10,
      134,
      1.0,
      0.0,
      "cycles",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    totalCyclesField.subfields.add(
      Subfield("TotalStrides", 134, 1.0, 0.0, "strides"),
    );
    totalCyclesField.subfields[subfieldIndex].addMap(5, 1);
    totalCyclesField.subfields[subfieldIndex].addMap(5, 11);
    subfieldIndex++;
    totalCyclesField.subfields.add(
      Subfield("TotalStrokes", 134, 1.0, 0.0, "strokes"),
    );
    totalCyclesField.subfields[subfieldIndex].addMap(5, 2);
    totalCyclesField.subfields[subfieldIndex].addMap(5, 5);
    totalCyclesField.subfields[subfieldIndex].addMap(5, 15);
    totalCyclesField.subfields[subfieldIndex].addMap(5, 37);
    subfieldIndex++;
    newMesg.setField(totalCyclesField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalCalories",
        11,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFatCalories",
        13,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    final Field avgSpeedField = Field(
      "AvgSpeed",
      14,
      132,
      1000.0,
      0.0,
      "m/s",
      false,
      ProfileType.uint16,
    );
    avgSpeedField.components.add(
      FieldComponent(124, false, 16, 1000.0, 0.0),
    ); // enhanced_avg_speed
    newMesg.setField(avgSpeedField);
    fieldIndex++;
    final Field maxSpeedField = Field(
      "MaxSpeed",
      15,
      132,
      1000.0,
      0.0,
      "m/s",
      false,
      ProfileType.uint16,
    );
    maxSpeedField.components.add(
      FieldComponent(125, false, 16, 1000.0, 0.0),
    ); // enhanced_max_speed
    newMesg.setField(maxSpeedField);
    fieldIndex++;
    newMesg.setField(
      Field("AvgHeartRate", 16, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxHeartRate", 17, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    final Field avgCadenceField = Field(
      "AvgCadence",
      18,
      2,
      1.0,
      0.0,
      "rpm",
      false,
      ProfileType.uint8,
    );
    subfieldIndex = 0;
    avgCadenceField.subfields.add(
      Subfield("AvgRunningCadence", 2, 1.0, 0.0, "strides/min"),
    );
    avgCadenceField.subfields[subfieldIndex].addMap(5, 1);
    subfieldIndex++;
    newMesg.setField(avgCadenceField);
    fieldIndex++;
    final Field maxCadenceField = Field(
      "MaxCadence",
      19,
      2,
      1.0,
      0.0,
      "rpm",
      false,
      ProfileType.uint8,
    );
    subfieldIndex = 0;
    maxCadenceField.subfields.add(
      Subfield("MaxRunningCadence", 2, 1.0, 0.0, "strides/min"),
    );
    maxCadenceField.subfields[subfieldIndex].addMap(5, 1);
    subfieldIndex++;
    newMesg.setField(maxCadenceField);
    fieldIndex++;
    newMesg.setField(
      Field("AvgPower", 20, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxPower", 21, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalAscent", 22, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalDescent", 23, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTrainingEffect",
        24,
        2,
        10.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FirstLapIndex", 25, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NumLaps", 26, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventGroup", 27, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Trigger", 28, 0, 1.0, 0.0, "", false, ProfileType.sessionTrigger),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NecLat",
        29,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NecLong",
        30,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SwcLat",
        31,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SwcLong",
        32,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NumLengths",
        33,
        132,
        1.0,
        0.0,
        "lengths",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NormalizedPower",
        34,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TrainingStressScore",
        35,
        132,
        10.0,
        0.0,
        "tss",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "IntensityFactor",
        36,
        132,
        1000.0,
        0.0,
        "if",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftRightBalance",
        37,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.leftRightBalance100,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLat",
        38,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLong",
        39,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStrokeCount",
        41,
        134,
        10.0,
        0.0,
        "strokes/lap",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStrokeDistance",
        42,
        132,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SwimStroke",
        43,
        0,
        1.0,
        0.0,
        "swim_stroke",
        false,
        ProfileType.swimStroke,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PoolLength", 44, 132, 100.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ThresholdPower",
        45,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PoolLengthUnit",
        46,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NumActiveLengths",
        47,
        132,
        1.0,
        0.0,
        "lengths",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalWork", 48, 134, 1.0, 0.0, "J", false, ProfileType.uint32),
    );
    fieldIndex++;
    final Field avgAltitudeField = Field(
      "AvgAltitude",
      49,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    avgAltitudeField.components.add(
      FieldComponent(126, false, 16, 5.0, 500.0),
    ); // enhanced_avg_altitude
    newMesg.setField(avgAltitudeField);
    fieldIndex++;
    final Field maxAltitudeField = Field(
      "MaxAltitude",
      50,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    maxAltitudeField.components.add(
      FieldComponent(128, false, 16, 5.0, 500.0),
    ); // enhanced_max_altitude
    newMesg.setField(maxAltitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("GpsAccuracy", 51, 2, 1.0, 0.0, "m", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgGrade", 52, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgPosGrade", 53, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgNegGrade", 54, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxPosGrade", 55, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxNegGrade", 56, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgTemperature", 57, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxTemperature", 58, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalMovingTime",
        59,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgPosVerticalSpeed",
        60,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgNegVerticalSpeed",
        61,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxPosVerticalSpeed",
        62,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxNegVerticalSpeed",
        63,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MinHeartRate", 64, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInHrZone",
        65,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInSpeedZone",
        66,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInCadenceZone",
        67,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInPowerZone",
        68,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgLapTime", 69, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BestLapIndex", 70, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    final Field minAltitudeField = Field(
      "MinAltitude",
      71,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    minAltitudeField.components.add(
      FieldComponent(127, false, 16, 5.0, 500.0),
    ); // enhanced_min_altitude
    newMesg.setField(minAltitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("PlayerScore", 82, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OpponentScore", 83, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OpponentName", 84, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StrokeCount",
        85,
        132,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ZoneCount",
        86,
        132,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxBallSpeed",
        87,
        132,
        100.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgBallSpeed",
        88,
        132,
        100.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgVerticalOscillation",
        89,
        132,
        10.0,
        0.0,
        "mm",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStanceTimePercent",
        90,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStanceTime",
        91,
        132,
        10.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgFractionalCadence",
        92,
        2,
        128.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxFractionalCadence",
        93,
        2,
        128.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalCycles",
        94,
        2,
        128.0,
        0.0,
        "cycles",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgTotalHemoglobinConc",
        95,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MinTotalHemoglobinConc",
        96,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxTotalHemoglobinConc",
        97,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgSaturatedHemoglobinPercent",
        98,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MinSaturatedHemoglobinPercent",
        99,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxSaturatedHemoglobinPercent",
        100,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftTorqueEffectiveness",
        101,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightTorqueEffectiveness",
        102,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPedalSmoothness",
        103,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPedalSmoothness",
        104,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCombinedPedalSmoothness",
        105,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SportProfileName",
        110,
        7,
        1.0,
        0.0,
        "",
        false,
        ProfileType.string,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SportIndex", 111, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeStanding",
        112,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StandCount", 113, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgLeftPco", 114, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgRightPco", 115, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPowerPhase",
        116,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPowerPhasePeak",
        117,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPowerPhase",
        118,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPowerPhasePeak",
        119,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgPowerPosition",
        120,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxPowerPosition",
        121,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCadencePosition",
        122,
        2,
        1.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxCadencePosition",
        123,
        2,
        1.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgSpeed",
        124,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxSpeed",
        125,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgAltitude",
        126,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMinAltitude",
        127,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxAltitude",
        128,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLevMotorPower",
        129,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxLevMotorPower",
        130,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LevBatteryConsumption",
        131,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgVerticalRatio",
        132,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStanceTimeBalance",
        133,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStepLength",
        134,
        132,
        10.0,
        0.0,
        "mm",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalAnaerobicTrainingEffect",
        137,
        2,
        10.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgVam", 139, 132, 1000.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgDepth", 140, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxDepth", 141, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SurfaceInterval",
        142,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartCns", 143, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndCns", 144, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartN2",
        145,
        132,
        1.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndN2", 146, 132, 1.0, 0.0, "percent", false, ProfileType.uint16),
    );
    fieldIndex++;
    final Field avgRespirationRateField = Field(
      "AvgRespirationRate",
      147,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    avgRespirationRateField.components.add(
      FieldComponent(169, false, 8, 1.0, 0.0),
    ); // enhanced_avg_respiration_rate
    newMesg.setField(avgRespirationRateField);
    fieldIndex++;
    final Field maxRespirationRateField = Field(
      "MaxRespirationRate",
      148,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    maxRespirationRateField.components.add(
      FieldComponent(170, false, 8, 1.0, 0.0),
    ); // enhanced_max_respiration_rate
    newMesg.setField(maxRespirationRateField);
    fieldIndex++;
    final Field minRespirationRateField = Field(
      "MinRespirationRate",
      149,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    minRespirationRateField.components.add(
      FieldComponent(180, false, 8, 1.0, 0.0),
    ); // enhanced_min_respiration_rate
    newMesg.setField(minRespirationRateField);
    fieldIndex++;
    newMesg.setField(
      Field("MinTemperature", 150, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "O2Toxicity",
        155,
        132,
        1.0,
        0.0,
        "OTUs",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DiveNumber", 156, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TrainingLoadPeak",
        168,
        133,
        65536.0,
        0.0,
        "",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgRespirationRate",
        169,
        132,
        100.0,
        0.0,
        "Breaths/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxRespirationRate",
        170,
        132,
        100.0,
        0.0,
        "Breaths/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMinRespirationRate",
        180,
        132,
        100.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalGrit",
        181,
        136,
        1.0,
        0.0,
        "kGrit",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFlow",
        182,
        136,
        1.0,
        0.0,
        "Flow",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("JumpCount", 183, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgGrit", 186, 136, 1.0, 0.0, "kGrit", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgFlow", 187, 136, 1.0, 0.0, "Flow", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WorkoutFeel", 192, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WorkoutRpe", 193, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgSpo2", 194, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgStress", 195, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SdrrHrv", 197, 2, 1.0, 0.0, "mS", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RmssdHrv", 198, 2, 1.0, 0.0, "mS", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalAscent",
        199,
        2,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalDescent",
        200,
        2,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCoreTemperature",
        208,
        132,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MinCoreTemperature",
        209,
        132,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxCoreTemperature",
        210,
        132,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    newMesg.setField(
      Field("ActiveTime", 78, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    newMesg.setField(
      Field("MetabolicCalories", 196, 132, 1.0, 0.0, "kcal", false,
          ProfileType.uint16),
    );
    return newMesg;
  }

  static Mesg createLapMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Lap", MesgNum.lap);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Event", 0, 0, 1.0, 0.0, "", false, ProfileType.event),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventType", 1, 0, 1.0, 0.0, "", false, ProfileType.eventType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartTime", 2, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLat",
        3,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLong",
        4,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLat",
        5,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLong",
        6,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalElapsedTime",
        7,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTimerTime",
        8,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalDistance",
        9,
        134,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    final Field totalCyclesField = Field(
      "TotalCycles",
      10,
      134,
      1.0,
      0.0,
      "cycles",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    totalCyclesField.subfields.add(
      Subfield("TotalStrides", 134, 1.0, 0.0, "strides"),
    );
    totalCyclesField.subfields[subfieldIndex].addMap(25, 1);
    totalCyclesField.subfields[subfieldIndex].addMap(25, 11);
    subfieldIndex++;
    totalCyclesField.subfields.add(
      Subfield("TotalStrokes", 134, 1.0, 0.0, "strokes"),
    );
    totalCyclesField.subfields[subfieldIndex].addMap(25, 2);
    totalCyclesField.subfields[subfieldIndex].addMap(25, 5);
    totalCyclesField.subfields[subfieldIndex].addMap(25, 15);
    totalCyclesField.subfields[subfieldIndex].addMap(25, 37);
    subfieldIndex++;
    newMesg.setField(totalCyclesField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalCalories",
        11,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFatCalories",
        12,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    final Field avgSpeedField = Field(
      "AvgSpeed",
      13,
      132,
      1000.0,
      0.0,
      "m/s",
      false,
      ProfileType.uint16,
    );
    avgSpeedField.components.add(
      FieldComponent(110, false, 16, 1000.0, 0.0),
    ); // enhanced_avg_speed
    newMesg.setField(avgSpeedField);
    fieldIndex++;
    final Field maxSpeedField = Field(
      "MaxSpeed",
      14,
      132,
      1000.0,
      0.0,
      "m/s",
      false,
      ProfileType.uint16,
    );
    maxSpeedField.components.add(
      FieldComponent(111, false, 16, 1000.0, 0.0),
    ); // enhanced_max_speed
    newMesg.setField(maxSpeedField);
    fieldIndex++;
    newMesg.setField(
      Field("AvgHeartRate", 15, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxHeartRate", 16, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    final Field avgCadenceField = Field(
      "AvgCadence",
      17,
      2,
      1.0,
      0.0,
      "rpm",
      false,
      ProfileType.uint8,
    );
    subfieldIndex = 0;
    avgCadenceField.subfields.add(
      Subfield("AvgRunningCadence", 2, 1.0, 0.0, "strides/min"),
    );
    avgCadenceField.subfields[subfieldIndex].addMap(25, 1);
    subfieldIndex++;
    newMesg.setField(avgCadenceField);
    fieldIndex++;
    final Field maxCadenceField = Field(
      "MaxCadence",
      18,
      2,
      1.0,
      0.0,
      "rpm",
      false,
      ProfileType.uint8,
    );
    subfieldIndex = 0;
    maxCadenceField.subfields.add(
      Subfield("MaxRunningCadence", 2, 1.0, 0.0, "strides/min"),
    );
    maxCadenceField.subfields[subfieldIndex].addMap(25, 1);
    subfieldIndex++;
    newMesg.setField(maxCadenceField);
    fieldIndex++;
    newMesg.setField(
      Field("AvgPower", 19, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxPower", 20, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalAscent", 21, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalDescent", 22, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Intensity", 23, 0, 1.0, 0.0, "", false, ProfileType.intensity),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LapTrigger", 24, 0, 1.0, 0.0, "", false, ProfileType.lapTrigger),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 25, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventGroup", 26, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NumLengths",
        32,
        132,
        1.0,
        0.0,
        "lengths",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NormalizedPower",
        33,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftRightBalance",
        34,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.leftRightBalance100,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FirstLengthIndex",
        35,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStrokeDistance",
        37,
        132,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SwimStroke", 38, 0, 1.0, 0.0, "", false, ProfileType.swimStroke),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 39, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NumActiveLengths",
        40,
        132,
        1.0,
        0.0,
        "lengths",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalWork", 41, 134, 1.0, 0.0, "J", false, ProfileType.uint32),
    );
    fieldIndex++;
    final Field avgAltitudeField = Field(
      "AvgAltitude",
      42,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    avgAltitudeField.components.add(
      FieldComponent(112, false, 16, 5.0, 500.0),
    ); // enhanced_avg_altitude
    newMesg.setField(avgAltitudeField);
    fieldIndex++;
    final Field maxAltitudeField = Field(
      "MaxAltitude",
      43,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    maxAltitudeField.components.add(
      FieldComponent(114, false, 16, 5.0, 500.0),
    ); // enhanced_max_altitude
    newMesg.setField(maxAltitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("GpsAccuracy", 44, 2, 1.0, 0.0, "m", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgGrade", 45, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgPosGrade", 46, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgNegGrade", 47, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxPosGrade", 48, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxNegGrade", 49, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgTemperature", 50, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxTemperature", 51, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalMovingTime",
        52,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgPosVerticalSpeed",
        53,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgNegVerticalSpeed",
        54,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxPosVerticalSpeed",
        55,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxNegVerticalSpeed",
        56,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInHrZone",
        57,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInSpeedZone",
        58,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInCadenceZone",
        59,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInPowerZone",
        60,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RepetitionNum", 61, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    final Field minAltitudeField = Field(
      "MinAltitude",
      62,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    minAltitudeField.components.add(
      FieldComponent(113, false, 16, 5.0, 500.0),
    ); // enhanced_min_altitude
    newMesg.setField(minAltitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("MinHeartRate", 63, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WktStepIndex",
        71,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OpponentScore", 74, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StrokeCount",
        75,
        132,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ZoneCount",
        76,
        132,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgVerticalOscillation",
        77,
        132,
        10.0,
        0.0,
        "mm",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStanceTimePercent",
        78,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStanceTime",
        79,
        132,
        10.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgFractionalCadence",
        80,
        2,
        128.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxFractionalCadence",
        81,
        2,
        128.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalCycles",
        82,
        2,
        128.0,
        0.0,
        "cycles",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PlayerScore", 83, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgTotalHemoglobinConc",
        84,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MinTotalHemoglobinConc",
        85,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxTotalHemoglobinConc",
        86,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgSaturatedHemoglobinPercent",
        87,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MinSaturatedHemoglobinPercent",
        88,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxSaturatedHemoglobinPercent",
        89,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftTorqueEffectiveness",
        91,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightTorqueEffectiveness",
        92,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPedalSmoothness",
        93,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPedalSmoothness",
        94,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCombinedPedalSmoothness",
        95,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeStanding",
        98,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StandCount", 99, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgLeftPco", 100, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgRightPco", 101, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPowerPhase",
        102,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPowerPhasePeak",
        103,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPowerPhase",
        104,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPowerPhasePeak",
        105,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgPowerPosition",
        106,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxPowerPosition",
        107,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCadencePosition",
        108,
        2,
        1.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxCadencePosition",
        109,
        2,
        1.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgSpeed",
        110,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxSpeed",
        111,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgAltitude",
        112,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMinAltitude",
        113,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxAltitude",
        114,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLevMotorPower",
        115,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxLevMotorPower",
        116,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LevBatteryConsumption",
        117,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgVerticalRatio",
        118,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStanceTimeBalance",
        119,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgStepLength",
        120,
        132,
        10.0,
        0.0,
        "mm",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgVam", 121, 132, 1000.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgDepth", 122, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxDepth", 123, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MinTemperature", 124, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgRespirationRate",
        136,
        132,
        100.0,
        0.0,
        "Breaths/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxRespirationRate",
        137,
        132,
        100.0,
        0.0,
        "Breaths/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    final Field lapAvgRespirationRateField = Field(
      "AvgRespirationRate",
      147,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    lapAvgRespirationRateField.components.add(
      FieldComponent(136, false, 8, 1.0, 0.0),
    ); // enhanced_avg_respiration_rate
    newMesg.setField(lapAvgRespirationRateField);
    fieldIndex++;
    final Field lapMaxRespirationRateField = Field(
      "MaxRespirationRate",
      148,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    lapMaxRespirationRateField.components.add(
      FieldComponent(137, false, 8, 1.0, 0.0),
    ); // enhanced_max_respiration_rate
    newMesg.setField(lapMaxRespirationRateField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalGrit",
        149,
        136,
        1.0,
        0.0,
        "kGrit",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFlow",
        150,
        136,
        1.0,
        0.0,
        "Flow",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("JumpCount", 151, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgGrit", 153, 136, 1.0, 0.0, "kGrit", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgFlow", 154, 136, 1.0, 0.0, "Flow", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalAscent",
        156,
        2,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalDescent",
        157,
        2,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCoreTemperature",
        158,
        132,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MinCoreTemperature",
        159,
        132,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxCoreTemperature",
        160,
        132,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    newMesg.setField(
      Field("ActiveTime", 70, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    return newMesg;
  }

  static Mesg createLengthMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Length", MesgNum.length);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Event", 0, 0, 1.0, 0.0, "", false, ProfileType.event),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventType", 1, 0, 1.0, 0.0, "", false, ProfileType.eventType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartTime", 2, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalElapsedTime",
        3,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTimerTime",
        4,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalStrokes",
        5,
        132,
        1.0,
        0.0,
        "strokes",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgSpeed", 6, 132, 1000.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SwimStroke",
        7,
        0,
        1.0,
        0.0,
        "swim_stroke",
        false,
        ProfileType.swimStroke,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgSwimmingCadence",
        9,
        2,
        1.0,
        0.0,
        "strokes/min",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventGroup", 10, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalCalories",
        11,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LengthType", 12, 0, 1.0, 0.0, "", false, ProfileType.lengthType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PlayerScore", 18, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OpponentScore", 19, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StrokeCount",
        20,
        132,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ZoneCount",
        21,
        132,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgRespirationRate",
        22,
        132,
        100.0,
        0.0,
        "Breaths/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxRespirationRate",
        23,
        132,
        100.0,
        0.0,
        "Breaths/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    final Field lengthAvgRespirationRateField = Field(
      "AvgRespirationRate",
      24,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    lengthAvgRespirationRateField.components.add(
      FieldComponent(22, false, 8, 1.0, 0.0),
    ); // enhanced_avg_respiration_rate
    newMesg.setField(lengthAvgRespirationRateField);
    fieldIndex++;
    final Field lengthMaxRespirationRateField = Field(
      "MaxRespirationRate",
      25,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    lengthMaxRespirationRateField.components.add(
      FieldComponent(23, false, 8, 1.0, 0.0),
    ); // enhanced_max_respiration_rate
    newMesg.setField(lengthMaxRespirationRateField);
    fieldIndex++;

    return newMesg;
  }

  static Mesg createRecordMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Record", MesgNum.record);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLat",
        0,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLong",
        1,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    final Field altitudeField = Field(
      "Altitude",
      2,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    altitudeField.components.add(
      FieldComponent(78, false, 16, 5.0, 500.0),
    ); // enhanced_altitude
    newMesg.setField(altitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("HeartRate", 3, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Cadence", 4, 2, 1.0, 0.0, "rpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Distance", 5, 134, 100.0, 0.0, "m", true, ProfileType.uint32),
    );
    fieldIndex++;
    final Field speedField = Field(
      "Speed",
      6,
      132,
      1000.0,
      0.0,
      "m/s",
      false,
      ProfileType.uint16,
    );
    speedField.components.add(
      FieldComponent(73, false, 16, 1000.0, 0.0),
    ); // enhanced_speed
    newMesg.setField(speedField);
    fieldIndex++;
    newMesg.setField(
      Field("Power", 7, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    final Field compressedSpeedDistanceField = Field(
      "CompressedSpeedDistance",
      8,
      13,
      1.0,
      0.0,
      "",
      false,
      ProfileType.byte,
    );
    compressedSpeedDistanceField.components.add(
      FieldComponent(6, false, 12, 100.0, 0.0),
    ); // speed
    compressedSpeedDistanceField.components.add(
      FieldComponent(5, true, 12, 16.0, 0.0),
    ); // distance
    newMesg.setField(compressedSpeedDistanceField);
    fieldIndex++;
    newMesg.setField(
      Field("Grade", 9, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Resistance", 10, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeFromCourse",
        11,
        133,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CycleLength", 12, 2, 100.0, 0.0, "m", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Temperature", 13, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Speed1s", 17, 2, 16.0, 0.0, "m/s", false, ProfileType.uint8),
    );
    fieldIndex++;
    final Field cyclesField = Field(
      "Cycles",
      18,
      2,
      1.0,
      0.0,
      "cycles",
      false,
      ProfileType.uint8,
    );
    cyclesField.components.add(
      FieldComponent(19, true, 8, 1.0, 0.0),
    ); // total_cycles
    newMesg.setField(cyclesField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalCycles",
        19,
        134,
        1.0,
        0.0,
        "cycles",
        true,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    final Field compressedAccumulatedPowerField = Field(
      "CompressedAccumulatedPower",
      28,
      132,
      1.0,
      0.0,
      "watts",
      false,
      ProfileType.uint16,
    );
    compressedAccumulatedPowerField.components.add(
      FieldComponent(29, true, 16, 1.0, 0.0),
    ); // accumulated_power
    newMesg.setField(compressedAccumulatedPowerField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "AccumulatedPower",
        29,
        134,
        1.0,
        0.0,
        "watts",
        true,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftRightBalance",
        30,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.leftRightBalance,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GpsAccuracy", 31, 2, 1.0, 0.0, "m", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "VerticalSpeed",
        32,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Calories", 33, 132, 1.0, 0.0, "kcal", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "VerticalOscillation",
        39,
        132,
        10.0,
        0.0,
        "mm",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StanceTimePercent",
        40,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StanceTime", 41, 132, 10.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityType",
        42,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.activityType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftTorqueEffectiveness",
        43,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RightTorqueEffectiveness",
        44,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftPedalSmoothness",
        45,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RightPedalSmoothness",
        46,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CombinedPedalSmoothness",
        47,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Time128", 48, 2, 128.0, 0.0, "s", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StrokeType", 49, 0, 1.0, 0.0, "", false, ProfileType.strokeType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Zone", 50, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BallSpeed", 51, 132, 100.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Cadence256",
        52,
        132,
        256.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FractionalCadence",
        53,
        2,
        128.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalHemoglobinConc",
        54,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalHemoglobinConcMin",
        55,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalHemoglobinConcMax",
        56,
        132,
        100.0,
        0.0,
        "g/dL",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SaturatedHemoglobinPercent",
        57,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SaturatedHemoglobinPercentMin",
        58,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SaturatedHemoglobinPercentMax",
        59,
        132,
        10.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceIndex", 62, 2, 1.0, 0.0, "", false, ProfileType.deviceIndex),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LeftPco", 67, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RightPco", 68, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftPowerPhase",
        69,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftPowerPhasePeak",
        70,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RightPowerPhase",
        71,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RightPowerPhasePeak",
        72,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedSpeed",
        73,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAltitude",
        78,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BatterySoc", 81, 2, 2.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MotorPower",
        82,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "VerticalRatio",
        83,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StanceTimeBalance",
        84,
        132,
        100.0,
        0.0,
        "percent",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StepLength", 85, 132, 10.0, 0.0, "mm", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CycleLength16",
        87,
        132,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AbsolutePressure",
        91,
        134,
        1.0,
        0.0,
        "Pa",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Depth", 92, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NextStopDepth",
        93,
        134,
        1000.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NextStopTime", 94, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeToSurface", 95, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NdlTime", 96, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CnsLoad", 97, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("N2Load", 98, 132, 1.0, 0.0, "percent", false, ProfileType.uint16),
    );
    fieldIndex++;
    final Field respirationRateField = Field(
      "RespirationRate",
      99,
      2,
      1.0,
      0.0,
      "s",
      false,
      ProfileType.uint8,
    );
    respirationRateField.components.add(
      FieldComponent(108, false, 8, 1.0, 0.0),
    ); // enhanced_respiration_rate
    newMesg.setField(respirationRateField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedRespirationRate",
        108,
        132,
        100.0,
        0.0,
        "Breaths/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Grit", 114, 136, 1.0, 0.0, "", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Flow", 115, 136, 1.0, 0.0, "", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CurrentStress",
        116,
        132,
        100.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EbikeTravelRange",
        117,
        132,
        1.0,
        0.0,
        "km",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EbikeBatteryLevel",
        118,
        2,
        1.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EbikeAssistMode",
        119,
        2,
        1.0,
        0.0,
        "depends on sensor",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EbikeAssistLevelPercent",
        120,
        2,
        1.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AirTimeRemaining",
        123,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PressureSac",
        124,
        132,
        100.0,
        0.0,
        "bar/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "VolumeSac",
        125,
        132,
        100.0,
        0.0,
        "L/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Rmv", 126, 132, 100.0, 0.0, "L/min", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AscentRate",
        127,
        133,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Po2", 129, 2, 100.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CoreTemperature",
        139,
        132,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createEventMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Event", MesgNum.event);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Event", 0, 0, 1.0, 0.0, "", false, ProfileType.event),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventType", 1, 0, 1.0, 0.0, "", false, ProfileType.eventType),
    );
    fieldIndex++;
    final Field data16Field = Field(
      "Data16",
      2,
      132,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint16,
    );
    data16Field.components.add(FieldComponent(3, false, 16, 1.0, 0.0)); // data
    newMesg.setField(data16Field);
    fieldIndex++;
    final Field dataField = Field(
      "Data",
      3,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    dataField.subfields.add(Subfield("TimerTrigger", 0, 1.0, 0.0, ""));
    dataField.subfields[subfieldIndex].addMap(0, 0);
    subfieldIndex++;
    dataField.subfields.add(Subfield("CoursePointIndex", 132, 1.0, 0.0, ""));
    dataField.subfields[subfieldIndex].addMap(0, 10);
    subfieldIndex++;
    dataField.subfields.add(Subfield("BatteryLevel", 132, 1000.0, 0.0, "V"));
    dataField.subfields[subfieldIndex].addMap(0, 11);
    subfieldIndex++;
    dataField.subfields.add(
      Subfield("VirtualPartnerSpeed", 132, 1000.0, 0.0, "m/s"),
    );
    dataField.subfields[subfieldIndex].addMap(0, 12);
    subfieldIndex++;
    dataField.subfields.add(Subfield("HrHighAlert", 2, 1.0, 0.0, "bpm"));
    dataField.subfields[subfieldIndex].addMap(0, 13);
    subfieldIndex++;
    dataField.subfields.add(Subfield("HrLowAlert", 2, 1.0, 0.0, "bpm"));
    dataField.subfields[subfieldIndex].addMap(0, 14);
    subfieldIndex++;
    dataField.subfields.add(
      Subfield("SpeedHighAlert", 134, 1000.0, 0.0, "m/s"),
    );
    dataField.subfields[subfieldIndex].addMap(0, 15);
    subfieldIndex++;
    dataField.subfields.add(Subfield("SpeedLowAlert", 134, 1000.0, 0.0, "m/s"));
    dataField.subfields[subfieldIndex].addMap(0, 16);
    subfieldIndex++;
    dataField.subfields.add(Subfield("CadHighAlert", 132, 1.0, 0.0, "rpm"));
    dataField.subfields[subfieldIndex].addMap(0, 17);
    subfieldIndex++;
    dataField.subfields.add(Subfield("CadLowAlert", 132, 1.0, 0.0, "rpm"));
    dataField.subfields[subfieldIndex].addMap(0, 18);
    subfieldIndex++;
    dataField.subfields.add(Subfield("PowerHighAlert", 132, 1.0, 0.0, "watts"));
    dataField.subfields[subfieldIndex].addMap(0, 19);
    subfieldIndex++;
    dataField.subfields.add(Subfield("PowerLowAlert", 132, 1.0, 0.0, "watts"));
    dataField.subfields[subfieldIndex].addMap(0, 20);
    subfieldIndex++;
    dataField.subfields.add(
      Subfield("TimeDurationAlert", 134, 1000.0, 0.0, "s"),
    );
    dataField.subfields[subfieldIndex].addMap(0, 23);
    subfieldIndex++;
    dataField.subfields.add(
      Subfield("DistanceDurationAlert", 134, 100.0, 0.0, "m"),
    );
    dataField.subfields[subfieldIndex].addMap(0, 24);
    subfieldIndex++;
    dataField.subfields.add(
      Subfield("CalorieDurationAlert", 134, 1.0, 0.0, "calories"),
    );
    dataField.subfields[subfieldIndex].addMap(0, 25);
    subfieldIndex++;
    dataField.subfields.add(Subfield("FitnessEquipmentState", 0, 1.0, 0.0, ""));
    dataField.subfields[subfieldIndex].addMap(0, 27);
    subfieldIndex++;
    final Subfield sportPointSubfield = Subfield(
      "SportPoint",
      134,
      1.0,
      0.0,
      "",
    );
    sportPointSubfield.addMap(0, 33);
    sportPointSubfield.addComponent(
      FieldComponent(7, false, 16, 1.0, 0.0),
    ); // score
    sportPointSubfield.addComponent(
      FieldComponent(8, false, 16, 1.0, 0.0),
    ); // opponent_score
    dataField.subfields.add(sportPointSubfield);
    subfieldIndex++;
    final Subfield gearChangeDataSubfield = Subfield(
      "GearChangeData",
      134,
      1.0,
      0.0,
      "",
    );
    gearChangeDataSubfield.addMap(0, 42);
    gearChangeDataSubfield.addMap(0, 43);
    gearChangeDataSubfield.addComponent(
      FieldComponent(11, false, 8, 1.0, 0.0),
    ); // rear_gear_num
    gearChangeDataSubfield.addComponent(
      FieldComponent(12, false, 8, 1.0, 0.0),
    ); // rear_gear
    gearChangeDataSubfield.addComponent(
      FieldComponent(9, false, 8, 1.0, 0.0),
    ); // front_gear_num
    gearChangeDataSubfield.addComponent(
      FieldComponent(10, false, 8, 1.0, 0.0),
    ); // front_gear
    dataField.subfields.add(gearChangeDataSubfield);
    subfieldIndex++;
    dataField.subfields.add(Subfield("RiderPosition", 0, 1.0, 0.0, ""));
    dataField.subfields[subfieldIndex].addMap(0, 44);
    subfieldIndex++;
    dataField.subfields.add(Subfield("CommTimeout", 132, 1.0, 0.0, ""));
    dataField.subfields[subfieldIndex].addMap(0, 47);
    subfieldIndex++;
    dataField.subfields.add(Subfield("DiveAlert", 0, 1.0, 0.0, ""));
    dataField.subfields[subfieldIndex].addMap(0, 56);
    subfieldIndex++;
    dataField.subfields.add(
      Subfield("AutoActivityDetectDuration", 132, 1.0, 0.0, "min"),
    );
    dataField.subfields[subfieldIndex].addMap(0, 54);
    subfieldIndex++;
    final Subfield radarThreatAlertSubfield = Subfield(
      "RadarThreatAlert",
      134,
      1.0,
      0.0,
      "",
    );
    radarThreatAlertSubfield.addMap(0, 75);
    radarThreatAlertSubfield.addComponent(
      FieldComponent(21, false, 8, 1.0, 0.0),
    ); // radar_threat_level_max
    radarThreatAlertSubfield.addComponent(
      FieldComponent(22, false, 8, 1.0, 0.0),
    ); // radar_threat_count
    radarThreatAlertSubfield.addComponent(
      FieldComponent(23, false, 8, 10.0, 0.0),
    ); // radar_threat_avg_approach_speed
    radarThreatAlertSubfield.addComponent(
      FieldComponent(24, false, 8, 10.0, 0.0),
    ); // radar_threat_max_approach_speed
    dataField.subfields.add(radarThreatAlertSubfield);
    subfieldIndex++;
    newMesg.setField(dataField);
    fieldIndex++;
    newMesg.setField(
      Field("EventGroup", 4, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Score", 7, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OpponentScore", 8, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FrontGearNum", 9, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FrontGear", 10, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RearGearNum", 11, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RearGear", 12, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceIndex", 13, 2, 1.0, 0.0, "", false, ProfileType.deviceIndex),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityType",
        14,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.activityType,
      ),
    );
    fieldIndex++;
    final Field startTimestampField = Field(
      "StartTimestamp",
      15,
      134,
      1.0,
      0.0,
      "s",
      false,
      ProfileType.dateTime,
    );
    subfieldIndex = 0;
    startTimestampField.subfields.add(
      Subfield("AutoActivityDetectStartTimestamp", 134, 1.0, 0.0, "s"),
    );
    startTimestampField.subfields[subfieldIndex].addMap(0, 54);
    subfieldIndex++;
    newMesg.setField(startTimestampField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "RadarThreatLevelMax",
        21,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.radarThreatLevelType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RadarThreatCount", 22, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RadarThreatAvgApproachSpeed",
        23,
        2,
        10.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RadarThreatMaxApproachSpeed",
        24,
        2,
        10.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDeviceInfoMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DeviceInfo", MesgNum.deviceInfo);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceIndex", 0, 2, 1.0, 0.0, "", false, ProfileType.deviceIndex),
    );
    fieldIndex++;
    final Field deviceTypeField = Field(
      "DeviceType",
      1,
      2,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint8,
    );
    subfieldIndex = 0;
    deviceTypeField.subfields.add(Subfield("BleDeviceType", 2, 1.0, 0.0, ""));
    deviceTypeField.subfields[subfieldIndex].addMap(25, 3);
    subfieldIndex++;
    deviceTypeField.subfields.add(
      Subfield("AntplusDeviceType", 2, 1.0, 0.0, ""),
    );
    deviceTypeField.subfields[subfieldIndex].addMap(25, 1);
    subfieldIndex++;
    deviceTypeField.subfields.add(Subfield("AntDeviceType", 2, 1.0, 0.0, ""));
    deviceTypeField.subfields[subfieldIndex].addMap(25, 0);
    subfieldIndex++;
    deviceTypeField.subfields.add(Subfield("LocalDeviceType", 2, 1.0, 0.0, ""));
    deviceTypeField.subfields[subfieldIndex].addMap(25, 5);
    subfieldIndex++;
    newMesg.setField(deviceTypeField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "Manufacturer",
        2,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.manufacturer,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SerialNumber", 3, 140, 1.0, 0.0, "", false, ProfileType.uint32z),
    );
    fieldIndex++;
    final Field productField = Field(
      "Product",
      4,
      132,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint16,
    );
    subfieldIndex = 0;
    productField.subfields.add(Subfield("FaveroProduct", 132, 1.0, 0.0, ""));
    productField.subfields[subfieldIndex].addMap(2, 263);
    subfieldIndex++;
    productField.subfields.add(Subfield("GarminProduct", 132, 1.0, 0.0, ""));
    productField.subfields[subfieldIndex].addMap(2, 1);
    productField.subfields[subfieldIndex].addMap(2, 15);
    productField.subfields[subfieldIndex].addMap(2, 13);
    productField.subfields[subfieldIndex].addMap(2, 89);
    subfieldIndex++;
    newMesg.setField(productField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "SoftwareVersion",
        5,
        132,
        100.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HardwareVersion", 6, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CumOperatingTime",
        7,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BatteryVoltage",
        10,
        132,
        256.0,
        0.0,
        "V",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BatteryStatus",
        11,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.batteryStatus,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SensorPosition",
        18,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.bodyLocation,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Descriptor", 19, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AntTransmissionType",
        20,
        10,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AntDeviceNumber",
        21,
        139,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16z,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AntNetwork", 22, 0, 1.0, 0.0, "", false, ProfileType.antNetwork),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SourceType", 25, 0, 1.0, 0.0, "", false, ProfileType.sourceType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ProductName", 27, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BatteryLevel", 32, 2, 1.0, 0.0, "%", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDeviceAuxBatteryInfoMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "DeviceAuxBatteryInfo",
      MesgNum.deviceAuxBatteryInfo,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceIndex", 0, 2, 1.0, 0.0, "", false, ProfileType.deviceIndex),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BatteryVoltage",
        1,
        132,
        256.0,
        0.0,
        "V",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BatteryStatus",
        2,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.batteryStatus,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BatteryIdentifier", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createTrainingFileMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("TrainingFile", MesgNum.trainingFile);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Type", 0, 0, 1.0, 0.0, "", false, ProfileType.file),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Manufacturer",
        1,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.manufacturer,
      ),
    );
    fieldIndex++;
    final Field productField = Field(
      "Product",
      2,
      132,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint16,
    );
    subfieldIndex = 0;
    productField.subfields.add(Subfield("FaveroProduct", 132, 1.0, 0.0, ""));
    productField.subfields[subfieldIndex].addMap(1, 263);
    subfieldIndex++;
    productField.subfields.add(Subfield("GarminProduct", 132, 1.0, 0.0, ""));
    productField.subfields[subfieldIndex].addMap(1, 1);
    productField.subfields[subfieldIndex].addMap(1, 15);
    productField.subfields[subfieldIndex].addMap(1, 13);
    productField.subfields[subfieldIndex].addMap(1, 89);
    subfieldIndex++;
    newMesg.setField(productField);
    fieldIndex++;
    newMesg.setField(
      Field("SerialNumber", 3, 140, 1.0, 0.0, "", false, ProfileType.uint32z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeCreated", 4, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createWeatherConditionsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("WeatherConditions", MesgNum.weatherConditions);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WeatherReport",
        0,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.weatherReport,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Temperature", 1, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Condition", 2, 0, 1.0, 0.0, "", false, ProfileType.weatherStatus),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WindDirection",
        3,
        132,
        1.0,
        0.0,
        "degrees",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WindSpeed", 4, 132, 1000.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PrecipitationProbability",
        5,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TemperatureFeelsLike",
        6,
        1,
        1.0,
        0.0,
        "C",
        false,
        ProfileType.sint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RelativeHumidity", 7, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Location", 8, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ObservedAtTime",
        9,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.dateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ObservedLocationLat",
        10,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ObservedLocationLong",
        11,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DayOfWeek", 12, 0, 1.0, 0.0, "", false, ProfileType.dayOfWeek),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HighTemperature", 13, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LowTemperature", 14, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createWeatherAlertMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("WeatherAlert", MesgNum.weatherAlert);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ReportId", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("IssueTime", 1, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ExpireTime", 2, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Severity", 3, 0, 1.0, 0.0, "", false, ProfileType.weatherSeverity),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Type", 4, 0, 1.0, 0.0, "", false, ProfileType.weatherSevereType),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createGpsMetadataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("GpsMetadata", MesgNum.gpsMetadata);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLat",
        1,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLong",
        2,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAltitude",
        3,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedSpeed",
        4,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Heading",
        5,
        132,
        100.0,
        0.0,
        "degrees",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("UtcTimestamp", 6, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Velocity", 7, 131, 100.0, 0.0, "m/s", false, ProfileType.sint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createCameraEventMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("CameraEvent", MesgNum.cameraEvent);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CameraEventType",
        1,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.cameraEventType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CameraFileUuid", 2, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CameraOrientation",
        3,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.cameraOrientationType,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createGyroscopeDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("GyroscopeData", MesgNum.gyroscopeData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SampleTimeOffset",
        1,
        132,
        1.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GyroX", 2, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GyroY", 3, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GyroZ", 4, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedGyroX",
        5,
        136,
        1.0,
        0.0,
        "deg/s",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedGyroY",
        6,
        136,
        1.0,
        0.0,
        "deg/s",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedGyroZ",
        7,
        136,
        1.0,
        0.0,
        "deg/s",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createAccelerometerDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("AccelerometerData", MesgNum.accelerometerData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SampleTimeOffset",
        1,
        132,
        1.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AccelX", 2, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AccelY", 3, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AccelZ", 4, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedAccelX",
        5,
        136,
        1.0,
        0.0,
        "g",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedAccelY",
        6,
        136,
        1.0,
        0.0,
        "g",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedAccelZ",
        7,
        136,
        1.0,
        0.0,
        "g",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CompressedCalibratedAccelX",
        8,
        131,
        1.0,
        0.0,
        "mG",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CompressedCalibratedAccelY",
        9,
        131,
        1.0,
        0.0,
        "mG",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CompressedCalibratedAccelZ",
        10,
        131,
        1.0,
        0.0,
        "mG",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMagnetometerDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("MagnetometerData", MesgNum.magnetometerData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SampleTimeOffset",
        1,
        132,
        1.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MagX", 2, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MagY", 3, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MagZ", 4, 132, 1.0, 0.0, "counts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedMagX",
        5,
        136,
        1.0,
        0.0,
        "G",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedMagY",
        6,
        136,
        1.0,
        0.0,
        "G",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibratedMagZ",
        7,
        136,
        1.0,
        0.0,
        "G",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createBarometerDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("BarometerData", MesgNum.barometerData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SampleTimeOffset",
        1,
        132,
        1.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BaroPres", 2, 134, 1.0, 0.0, "Pa", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createThreeDSensorCalibrationMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "ThreeDSensorCalibration",
      MesgNum.threeDSensorCalibration,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SensorType", 0, 0, 1.0, 0.0, "", false, ProfileType.sensorType),
    );
    fieldIndex++;
    final Field calibrationFactorField = Field(
      "CalibrationFactor",
      1,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    calibrationFactorField.subfields.add(
      Subfield("AccelCalFactor", 134, 1.0, 0.0, "g"),
    );
    calibrationFactorField.subfields[subfieldIndex].addMap(0, 0);
    subfieldIndex++;
    calibrationFactorField.subfields.add(
      Subfield("GyroCalFactor", 134, 1.0, 0.0, "deg/s"),
    );
    calibrationFactorField.subfields[subfieldIndex].addMap(0, 1);
    subfieldIndex++;
    newMesg.setField(calibrationFactorField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibrationDivisor",
        2,
        134,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LevelShift", 3, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OffsetCal", 4, 133, 1.0, 0.0, "", false, ProfileType.sint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "OrientationMatrix",
        5,
        133,
        65535.0,
        0.0,
        "",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createOneDSensorCalibrationMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "OneDSensorCalibration",
      MesgNum.oneDSensorCalibration,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SensorType", 0, 0, 1.0, 0.0, "", false, ProfileType.sensorType),
    );
    fieldIndex++;
    final Field calibrationFactorField = Field(
      "CalibrationFactor",
      1,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    calibrationFactorField.subfields.add(
      Subfield("BaroCalFactor", 134, 1.0, 0.0, "Pa"),
    );
    calibrationFactorField.subfields[subfieldIndex].addMap(0, 3);
    subfieldIndex++;
    newMesg.setField(calibrationFactorField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "CalibrationDivisor",
        2,
        134,
        1.0,
        0.0,
        "counts",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LevelShift", 3, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OffsetCal", 4, 133, 1.0, 0.0, "", false, ProfileType.sint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createVideoFrameMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("VideoFrame", MesgNum.videoFrame);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FrameNumber", 1, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createObdiiDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("ObdiiData", MesgNum.obdiiData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeOffset", 1, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Pid", 2, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RawData", 3, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PidDataSize", 4, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SystemTime", 5, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartTimestamp",
        6,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.dateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartTimestampMs",
        7,
        132,
        1.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createNmeaSentenceMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("NmeaSentence", MesgNum.nmeaSentence);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sentence", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createAviationAttitudeMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("AviationAttitude", MesgNum.aviationAttitude);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SystemTime", 1, 134, 1.0, 0.0, "ms", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Pitch",
        2,
        131,
        10430.38,
        0.0,
        "radians",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Roll",
        3,
        131,
        10430.38,
        0.0,
        "radians",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AccelLateral",
        4,
        131,
        100.0,
        0.0,
        "m/s^2",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AccelNormal",
        5,
        131,
        100.0,
        0.0,
        "m/s^2",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TurnRate",
        6,
        131,
        1024.0,
        0.0,
        "radians/second",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Stage", 7, 0, 1.0, 0.0, "", false, ProfileType.attitudeStage),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AttitudeStageComplete",
        8,
        2,
        1.0,
        0.0,
        "%",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Track",
        9,
        132,
        10430.38,
        0.0,
        "radians",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Validity",
        10,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.attitudeValidity,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createVideoMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Video", MesgNum.video);
    fieldIndex = 0;
    newMesg.setField(
      Field("Url", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HostingProvider", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Duration", 2, 134, 1.0, 0.0, "ms", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createVideoTitleMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("VideoTitle", MesgNum.videoTitle);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MessageCount", 0, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Text", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createVideoDescriptionMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("VideoDescription", MesgNum.videoDescription);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MessageCount", 0, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Text", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createVideoClipMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("VideoClip", MesgNum.videoClip);
    fieldIndex = 0;
    newMesg.setField(
      Field("ClipNumber", 0, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartTimestamp",
        1,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.dateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartTimestampMs",
        2,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndTimestamp", 3, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndTimestampMs", 4, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ClipStart", 6, 134, 1.0, 0.0, "ms", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ClipEnd", 7, 134, 1.0, 0.0, "ms", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSetMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Set", MesgNum.set_);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 254, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Duration", 0, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Repetitions", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Weight", 4, 132, 16.0, 0.0, "kg", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SetType", 5, 2, 1.0, 0.0, "", false, ProfileType.setType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartTime", 6, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Category",
        7,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.exerciseCategory,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CategorySubtype", 8, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WeightDisplayUnit",
        9,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.fitBaseUnit,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MessageIndex",
        10,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WktStepIndex",
        11,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createJumpMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Jump", MesgNum.jump);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Distance", 0, 136, 1.0, 0.0, "m", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Height", 1, 136, 1.0, 0.0, "m", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Rotations", 2, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HangTime", 3, 136, 1.0, 0.0, "s", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Score", 4, 136, 1.0, 0.0, "", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLat",
        5,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLong",
        6,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    final Field speedField = Field(
      "Speed",
      7,
      132,
      1000.0,
      0.0,
      "m/s",
      false,
      ProfileType.uint16,
    );
    speedField.components.add(
      FieldComponent(8, false, 16, 1000.0, 0.0),
    ); // enhanced_speed
    newMesg.setField(speedField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedSpeed",
        8,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSplitMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Split", MesgNum.split);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SplitType", 0, 0, 1.0, 0.0, "", false, ProfileType.splitType),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalElapsedTime",
        1,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTimerTime",
        2,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalDistance",
        3,
        134,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgSpeed", 4, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartTime", 9, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalAscent", 13, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalDescent", 14, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLat",
        21,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLong",
        22,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLat",
        23,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLong",
        24,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxSpeed", 25, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgVertSpeed",
        26,
        133,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndTime", 27, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalCalories",
        28,
        134,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartElevation",
        74,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalMovingTime",
        110,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    newMesg.setField(
      Field("ActiveTime", 78, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    return newMesg;
  }

  static Mesg createSplitSummaryMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SplitSummary", MesgNum.splitSummary);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SplitType", 0, 0, 1.0, 0.0, "", false, ProfileType.splitType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NumSplits", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTimerTime",
        4,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalDistance",
        5,
        134,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgSpeed", 6, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxSpeed", 7, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalAscent", 8, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalDescent", 9, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgHeartRate", 10, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxHeartRate", 11, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgVertSpeed",
        12,
        133,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalCalories",
        13,
        134,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalMovingTime",
        77,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    newMesg.setField(
      Field("ActiveTime", 65, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    return newMesg;
  }

  static Mesg createClimbProMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("ClimbPro", MesgNum.climbPro);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLat",
        0,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLong",
        1,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ClimbProEvent",
        2,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.climbProEvent,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ClimbNumber", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ClimbCategory", 4, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CurrentDist", 5, 136, 1.0, 0.0, "m", false, ProfileType.float32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createFieldDescriptionMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("FieldDescription", MesgNum.fieldDescription);
    fieldIndex = 0;
    newMesg.setField(
      Field("DeveloperDataIndex", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FieldDefinitionNumber",
        1,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FitBaseTypeId",
        2,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.fitBaseType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FieldName", 3, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Array", 4, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Components", 5, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Scale", 6, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Offset", 7, 1, 1.0, 0.0, "", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Units", 8, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Bits", 9, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Accumulate", 10, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FitBaseUnitId",
        13,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.fitBaseUnit,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NativeMesgNum", 14, 132, 1.0, 0.0, "", false, ProfileType.mesgNum),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NativeFieldNum", 15, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDeveloperDataIdMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DeveloperDataId", MesgNum.developerDataId);
    fieldIndex = 0;
    newMesg.setField(
      Field("DeveloperId", 0, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ApplicationId", 1, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ManufacturerId",
        2,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.manufacturer,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeveloperDataIndex", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ApplicationVersion",
        4,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createCourseMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Course", MesgNum.course);
    fieldIndex = 0;
    newMesg.setField(
      Field("Sport", 4, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 5, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Capabilities",
        6,
        140,
        1.0,
        0.0,
        "",
        false,
        ProfileType.courseCapabilities,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 7, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createCoursePointMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("CoursePoint", MesgNum.coursePoint);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp", 1, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLat",
        2,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLong",
        3,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Distance", 4, 134, 100.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Type", 5, 0, 1.0, 0.0, "", false, ProfileType.coursePoint),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 6, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Favorite", 8, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSegmentIdMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SegmentId", MesgNum.segmentId);
    fieldIndex = 0;
    newMesg.setField(
      Field("Name", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Uuid", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 2, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 3, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "UserProfilePrimaryKey",
        4,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceId", 5, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DefaultRaceLeader", 6, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DeleteStatus",
        7,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.segmentDeleteStatus,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SelectionType",
        8,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.segmentSelectionType,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSegmentLeaderboardEntryMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "SegmentLeaderboardEntry",
      MesgNum.segmentLeaderboardEntry,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Type",
        1,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.segmentLeaderboardType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GroupPrimaryKey", 2, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;

    newMesg.setField(
      Field("ActivityId", 3, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    newMesg.setField(
      Field("SegmentTime", 4, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    newMesg.setField(
      Field("ActivityIdString", 5, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    return newMesg;
  }

  static Mesg createSegmentPointMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SegmentPoint", MesgNum.segmentPoint);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLat",
        1,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PositionLong",
        2,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Distance", 3, 134, 100.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    final Field altitudeField = Field(
      "Altitude",
      4,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    altitudeField.components.add(
      FieldComponent(6, false, 16, 5.0, 500.0),
    ); // enhanced_altitude
    newMesg.setField(altitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("LeaderTime", 5, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAltitude",
        6,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSegmentLapMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SegmentLap", MesgNum.segmentLap);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Event", 0, 0, 1.0, 0.0, "", false, ProfileType.event),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventType", 1, 0, 1.0, 0.0, "", false, ProfileType.eventType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartTime", 2, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLat",
        3,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPositionLong",
        4,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLat",
        5,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPositionLong",
        6,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalElapsedTime",
        7,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalTimerTime",
        8,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalDistance",
        9,
        134,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    final Field totalCyclesField = Field(
      "TotalCycles",
      10,
      134,
      1.0,
      0.0,
      "cycles",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    totalCyclesField.subfields.add(
      Subfield("TotalStrokes", 134, 1.0, 0.0, "strokes"),
    );
    totalCyclesField.subfields[subfieldIndex].addMap(23, 2);
    subfieldIndex++;
    newMesg.setField(totalCyclesField);
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalCalories",
        11,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFatCalories",
        12,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgSpeed", 13, 132, 1000.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxSpeed", 14, 132, 1000.0, 0.0, "m/s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgHeartRate", 15, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxHeartRate", 16, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgCadence", 17, 2, 1.0, 0.0, "rpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxCadence", 18, 2, 1.0, 0.0, "rpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgPower", 19, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxPower", 20, 132, 1.0, 0.0, "watts", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalAscent", 21, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalDescent", 22, 132, 1.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 23, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventGroup", 24, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NecLat",
        25,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NecLong",
        26,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SwcLat",
        27,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SwcLong",
        28,
        133,
        1.0,
        0.0,
        "semicircles",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Name", 29, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "NormalizedPower",
        30,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeftRightBalance",
        31,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.leftRightBalance100,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 32, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalWork", 33, 134, 1.0, 0.0, "J", false, ProfileType.uint32),
    );
    fieldIndex++;
    final Field avgAltitudeField = Field(
      "AvgAltitude",
      34,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    avgAltitudeField.components.add(
      FieldComponent(91, false, 16, 5.0, 500.0),
    ); // enhanced_avg_altitude
    newMesg.setField(avgAltitudeField);
    fieldIndex++;
    final Field maxAltitudeField = Field(
      "MaxAltitude",
      35,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    maxAltitudeField.components.add(
      FieldComponent(92, false, 16, 5.0, 500.0),
    ); // enhanced_max_altitude
    newMesg.setField(maxAltitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("GpsAccuracy", 36, 2, 1.0, 0.0, "m", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgGrade", 37, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgPosGrade", 38, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgNegGrade", 39, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxPosGrade", 40, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxNegGrade", 41, 131, 100.0, 0.0, "%", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgTemperature", 42, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxTemperature", 43, 1, 1.0, 0.0, "C", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalMovingTime",
        44,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgPosVerticalSpeed",
        45,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgNegVerticalSpeed",
        46,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxPosVerticalSpeed",
        47,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxNegVerticalSpeed",
        48,
        131,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInHrZone",
        49,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInSpeedZone",
        50,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInCadenceZone",
        51,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeInPowerZone",
        52,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RepetitionNum", 53, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    final Field minAltitudeField = Field(
      "MinAltitude",
      54,
      132,
      5.0,
      500.0,
      "m",
      false,
      ProfileType.uint16,
    );
    minAltitudeField.components.add(
      FieldComponent(93, false, 16, 5.0, 500.0),
    ); // enhanced_min_altitude
    newMesg.setField(minAltitudeField);
    fieldIndex++;
    newMesg.setField(
      Field("MinHeartRate", 55, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ActiveTime", 56, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WktStepIndex",
        57,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SportEvent", 58, 0, 1.0, 0.0, "", false, ProfileType.sportEvent),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftTorqueEffectiveness",
        59,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightTorqueEffectiveness",
        60,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPedalSmoothness",
        61,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPedalSmoothness",
        62,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCombinedPedalSmoothness",
        63,
        2,
        2.0,
        0.0,
        "percent",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Status", 64, 0, 1.0, 0.0, "", false, ProfileType.segmentLapStatus),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Uuid", 65, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgFractionalCadence",
        66,
        2,
        128.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxFractionalCadence",
        67,
        2,
        128.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalCycles",
        68,
        2,
        128.0,
        0.0,
        "cycles",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FrontGearShiftCount",
        69,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RearGearShiftCount",
        70,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeStanding",
        71,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StandCount", 72, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgLeftPco", 73, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgRightPco", 74, 1, 1.0, 0.0, "mm", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPowerPhase",
        75,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgLeftPowerPhasePeak",
        76,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPowerPhase",
        77,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgRightPowerPhasePeak",
        78,
        2,
        0.7111111,
        0.0,
        "degrees",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgPowerPosition",
        79,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxPowerPosition",
        80,
        132,
        1.0,
        0.0,
        "watts",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgCadencePosition",
        81,
        2,
        1.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxCadencePosition",
        82,
        2,
        1.0,
        0.0,
        "rpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Manufacturer",
        83,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.manufacturer,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalGrit",
        84,
        136,
        1.0,
        0.0,
        "kGrit",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TotalFlow", 85, 136, 1.0, 0.0, "Flow", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgGrit", 86, 136, 1.0, 0.0, "kGrit", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgFlow", 87, 136, 1.0, 0.0, "Flow", false, ProfileType.float32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalAscent",
        89,
        2,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TotalFractionalDescent",
        90,
        2,
        100.0,
        0.0,
        "m",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedAvgAltitude",
        91,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMaxAltitude",
        92,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EnhancedMinAltitude",
        93,
        134,
        5.0,
        500.0,
        "m",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSegmentFileMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SegmentFile", MesgNum.segmentFile);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FileUuid", 1, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Enabled", 3, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "UserProfilePrimaryKey",
        4,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeaderType",
        7,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.segmentLeaderboardType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeaderGroupPrimaryKey",
        8,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeaderActivityId",
        9,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LeaderActivityIdString",
        10,
        7,
        1.0,
        0.0,
        "",
        false,
        ProfileType.string,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DefaultRaceLeader", 11, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createWorkoutMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Workout", MesgNum.workout);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 4, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Capabilities",
        5,
        140,
        1.0,
        0.0,
        "",
        false,
        ProfileType.workoutCapabilities,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NumValidSteps", 6, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WktName", 8, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 11, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WktDescription", 17, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    newMesg.setField(
      Field("PoolLength", 14, 132, 100.0, 0.0, "m", false, ProfileType.uint16),
    );
    newMesg.setField(
      Field("PoolLengthUnit", 15, 0, 1.0, 0.0, "", false,
          ProfileType.displayMeasure),
    );
    return newMesg;
  }

  static Mesg createWorkoutSessionMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("WorkoutSession", MesgNum.workoutSession);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 0, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 1, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NumValidSteps", 2, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FirstStepIndex", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PoolLength", 4, 132, 100.0, 0.0, "m", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PoolLengthUnit",
        5,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.displayMeasure,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createWorkoutStepMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("WorkoutStep", MesgNum.workoutStep);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WktStepName", 0, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DurationType",
        1,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.wktStepDuration,
      ),
    );
    fieldIndex++;
    final Field durationValueField = Field(
      "DurationValue",
      2,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    durationValueField.subfields.add(
      Subfield("DurationTime", 134, 1000.0, 0.0, "s"),
    );
    durationValueField.subfields[subfieldIndex].addMap(1, 0);
    durationValueField.subfields[subfieldIndex].addMap(1, 28);
    subfieldIndex++;
    durationValueField.subfields.add(
      Subfield("DurationDistance", 134, 100.0, 0.0, "m"),
    );
    durationValueField.subfields[subfieldIndex].addMap(1, 1);
    subfieldIndex++;
    durationValueField.subfields.add(
      Subfield("DurationHr", 134, 1.0, 0.0, "% or bpm"),
    );
    durationValueField.subfields[subfieldIndex].addMap(1, 2);
    durationValueField.subfields[subfieldIndex].addMap(1, 3);
    subfieldIndex++;
    durationValueField.subfields.add(
      Subfield("DurationCalories", 134, 1.0, 0.0, "calories"),
    );
    durationValueField.subfields[subfieldIndex].addMap(1, 4);
    subfieldIndex++;
    durationValueField.subfields.add(
      Subfield("DurationStep", 134, 1.0, 0.0, ""),
    );
    durationValueField.subfields[subfieldIndex].addMap(1, 6);
    durationValueField.subfields[subfieldIndex].addMap(1, 7);
    durationValueField.subfields[subfieldIndex].addMap(1, 8);
    durationValueField.subfields[subfieldIndex].addMap(1, 9);
    durationValueField.subfields[subfieldIndex].addMap(1, 10);
    durationValueField.subfields[subfieldIndex].addMap(1, 11);
    durationValueField.subfields[subfieldIndex].addMap(1, 12);
    durationValueField.subfields[subfieldIndex].addMap(1, 13);
    subfieldIndex++;
    durationValueField.subfields.add(
      Subfield("DurationPower", 134, 1.0, 0.0, "% or watts"),
    );
    durationValueField.subfields[subfieldIndex].addMap(1, 14);
    durationValueField.subfields[subfieldIndex].addMap(1, 15);
    subfieldIndex++;
    durationValueField.subfields.add(
      Subfield("DurationReps", 134, 1.0, 0.0, ""),
    );
    durationValueField.subfields[subfieldIndex].addMap(1, 29);
    subfieldIndex++;
    newMesg.setField(durationValueField);
    fieldIndex++;
    newMesg.setField(
      Field("TargetType", 3, 0, 1.0, 0.0, "", false, ProfileType.wktStepTarget),
    );
    fieldIndex++;
    final Field targetValueField = Field(
      "TargetValue",
      4,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    targetValueField.subfields.add(
      Subfield("TargetSpeedZone", 134, 1.0, 0.0, ""),
    );
    targetValueField.subfields[subfieldIndex].addMap(3, 0);
    subfieldIndex++;
    targetValueField.subfields.add(Subfield("TargetHrZone", 134, 1.0, 0.0, ""));
    targetValueField.subfields[subfieldIndex].addMap(3, 1);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("TargetCadenceZone", 134, 1.0, 0.0, ""),
    );
    targetValueField.subfields[subfieldIndex].addMap(3, 3);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("TargetPowerZone", 134, 1.0, 0.0, ""),
    );
    targetValueField.subfields[subfieldIndex].addMap(3, 4);
    subfieldIndex++;
    targetValueField.subfields.add(Subfield("RepeatSteps", 134, 1.0, 0.0, ""));
    targetValueField.subfields[subfieldIndex].addMap(1, 6);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("RepeatTime", 134, 1000.0, 0.0, "s"),
    );
    targetValueField.subfields[subfieldIndex].addMap(1, 7);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("RepeatDistance", 134, 100.0, 0.0, "m"),
    );
    targetValueField.subfields[subfieldIndex].addMap(1, 8);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("RepeatCalories", 134, 1.0, 0.0, "calories"),
    );
    targetValueField.subfields[subfieldIndex].addMap(1, 9);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("RepeatHr", 134, 1.0, 0.0, "% or bpm"),
    );
    targetValueField.subfields[subfieldIndex].addMap(1, 10);
    targetValueField.subfields[subfieldIndex].addMap(1, 11);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("RepeatPower", 134, 1.0, 0.0, "% or watts"),
    );
    targetValueField.subfields[subfieldIndex].addMap(1, 12);
    targetValueField.subfields[subfieldIndex].addMap(1, 13);
    subfieldIndex++;
    targetValueField.subfields.add(
      Subfield("TargetStrokeType", 0, 1.0, 0.0, ""),
    );
    targetValueField.subfields[subfieldIndex].addMap(3, 11);
    subfieldIndex++;
    newMesg.setField(targetValueField);
    fieldIndex++;
    final Field customTargetValueLowField = Field(
      "CustomTargetValueLow",
      5,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    customTargetValueLowField.subfields.add(
      Subfield("CustomTargetSpeedLow", 134, 1000.0, 0.0, "m/s"),
    );
    customTargetValueLowField.subfields[subfieldIndex].addMap(3, 0);
    subfieldIndex++;
    customTargetValueLowField.subfields.add(
      Subfield("CustomTargetHeartRateLow", 134, 1.0, 0.0, "% or bpm"),
    );
    customTargetValueLowField.subfields[subfieldIndex].addMap(3, 1);
    subfieldIndex++;
    customTargetValueLowField.subfields.add(
      Subfield("CustomTargetCadenceLow", 134, 1.0, 0.0, "rpm"),
    );
    customTargetValueLowField.subfields[subfieldIndex].addMap(3, 3);
    subfieldIndex++;
    customTargetValueLowField.subfields.add(
      Subfield("CustomTargetPowerLow", 134, 1.0, 0.0, "% or watts"),
    );
    customTargetValueLowField.subfields[subfieldIndex].addMap(3, 4);
    subfieldIndex++;
    newMesg.setField(customTargetValueLowField);
    fieldIndex++;
    final Field customTargetValueHighField = Field(
      "CustomTargetValueHigh",
      6,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    customTargetValueHighField.subfields.add(
      Subfield("CustomTargetSpeedHigh", 134, 1000.0, 0.0, "m/s"),
    );
    customTargetValueHighField.subfields[subfieldIndex].addMap(3, 0);
    subfieldIndex++;
    customTargetValueHighField.subfields.add(
      Subfield("CustomTargetHeartRateHigh", 134, 1.0, 0.0, "% or bpm"),
    );
    customTargetValueHighField.subfields[subfieldIndex].addMap(3, 1);
    subfieldIndex++;
    customTargetValueHighField.subfields.add(
      Subfield("CustomTargetCadenceHigh", 134, 1.0, 0.0, "rpm"),
    );
    customTargetValueHighField.subfields[subfieldIndex].addMap(3, 3);
    subfieldIndex++;
    customTargetValueHighField.subfields.add(
      Subfield("CustomTargetPowerHigh", 134, 1.0, 0.0, "% or watts"),
    );
    customTargetValueHighField.subfields[subfieldIndex].addMap(3, 4);
    subfieldIndex++;
    newMesg.setField(customTargetValueHighField);
    fieldIndex++;
    newMesg.setField(
      Field("Intensity", 7, 0, 1.0, 0.0, "", false, ProfileType.intensity),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Notes", 8, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Equipment",
        9,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.workoutEquipment,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ExerciseCategory",
        10,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.exerciseCategory,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ExerciseName", 11, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ExerciseWeight",
        12,
        132,
        100.0,
        0.0,
        "kg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WeightDisplayUnit",
        13,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.fitBaseUnit,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SecondaryTargetType",
        19,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.wktStepTarget,
      ),
    );
    fieldIndex++;
    final Field secondaryTargetValueField = Field(
      "SecondaryTargetValue",
      20,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    secondaryTargetValueField.subfields.add(
      Subfield("SecondaryTargetSpeedZone", 134, 1.0, 0.0, ""),
    );
    secondaryTargetValueField.subfields[subfieldIndex].addMap(19, 0);
    subfieldIndex++;
    secondaryTargetValueField.subfields.add(
      Subfield("SecondaryTargetHrZone", 134, 1.0, 0.0, ""),
    );
    secondaryTargetValueField.subfields[subfieldIndex].addMap(19, 1);
    subfieldIndex++;
    secondaryTargetValueField.subfields.add(
      Subfield("SecondaryTargetCadenceZone", 134, 1.0, 0.0, ""),
    );
    secondaryTargetValueField.subfields[subfieldIndex].addMap(19, 3);
    subfieldIndex++;
    secondaryTargetValueField.subfields.add(
      Subfield("SecondaryTargetPowerZone", 134, 1.0, 0.0, ""),
    );
    secondaryTargetValueField.subfields[subfieldIndex].addMap(19, 4);
    subfieldIndex++;
    secondaryTargetValueField.subfields.add(
      Subfield("SecondaryTargetStrokeType", 0, 1.0, 0.0, ""),
    );
    secondaryTargetValueField.subfields[subfieldIndex].addMap(19, 11);
    subfieldIndex++;
    newMesg.setField(secondaryTargetValueField);
    fieldIndex++;
    final Field secondaryCustomTargetValueLowField = Field(
      "SecondaryCustomTargetValueLow",
      21,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    secondaryCustomTargetValueLowField.subfields.add(
      Subfield("SecondaryCustomTargetSpeedLow", 134, 1000.0, 0.0, "m/s"),
    );
    secondaryCustomTargetValueLowField.subfields[subfieldIndex].addMap(19, 0);
    subfieldIndex++;
    secondaryCustomTargetValueLowField.subfields.add(
      Subfield("SecondaryCustomTargetHeartRateLow", 134, 1.0, 0.0, "% or bpm"),
    );
    secondaryCustomTargetValueLowField.subfields[subfieldIndex].addMap(19, 1);
    subfieldIndex++;
    secondaryCustomTargetValueLowField.subfields.add(
      Subfield("SecondaryCustomTargetCadenceLow", 134, 1.0, 0.0, "rpm"),
    );
    secondaryCustomTargetValueLowField.subfields[subfieldIndex].addMap(19, 3);
    subfieldIndex++;
    secondaryCustomTargetValueLowField.subfields.add(
      Subfield("SecondaryCustomTargetPowerLow", 134, 1.0, 0.0, "% or watts"),
    );
    secondaryCustomTargetValueLowField.subfields[subfieldIndex].addMap(19, 4);
    subfieldIndex++;
    newMesg.setField(secondaryCustomTargetValueLowField);
    fieldIndex++;
    final Field secondaryCustomTargetValueHighField = Field(
      "SecondaryCustomTargetValueHigh",
      22,
      134,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    secondaryCustomTargetValueHighField.subfields.add(
      Subfield("SecondaryCustomTargetSpeedHigh", 134, 1000.0, 0.0, "m/s"),
    );
    secondaryCustomTargetValueHighField.subfields[subfieldIndex].addMap(19, 0);
    subfieldIndex++;
    secondaryCustomTargetValueHighField.subfields.add(
      Subfield("SecondaryCustomTargetHeartRateHigh", 134, 1.0, 0.0, "% or bpm"),
    );
    secondaryCustomTargetValueHighField.subfields[subfieldIndex].addMap(19, 1);
    subfieldIndex++;
    secondaryCustomTargetValueHighField.subfields.add(
      Subfield("SecondaryCustomTargetCadenceHigh", 134, 1.0, 0.0, "rpm"),
    );
    secondaryCustomTargetValueHighField.subfields[subfieldIndex].addMap(19, 3);
    subfieldIndex++;
    secondaryCustomTargetValueHighField.subfields.add(
      Subfield("SecondaryCustomTargetPowerHigh", 134, 1.0, 0.0, "% or watts"),
    );
    secondaryCustomTargetValueHighField.subfields[subfieldIndex].addMap(19, 4);
    subfieldIndex++;
    newMesg.setField(secondaryCustomTargetValueHighField);
    fieldIndex++;

    return newMesg;
  }

  static Mesg createExerciseTitleMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("ExerciseTitle", MesgNum.exerciseTitle);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ExerciseCategory",
        0,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.exerciseCategory,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ExerciseName", 1, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("WktStepName", 2, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createScheduleMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Schedule", MesgNum.schedule);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "Manufacturer",
        0,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.manufacturer,
      ),
    );
    fieldIndex++;
    final Field productField = Field(
      "Product",
      1,
      132,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint16,
    );
    subfieldIndex = 0;
    productField.subfields.add(Subfield("FaveroProduct", 132, 1.0, 0.0, ""));
    productField.subfields[subfieldIndex].addMap(0, 263);
    subfieldIndex++;
    productField.subfields.add(Subfield("GarminProduct", 132, 1.0, 0.0, ""));
    productField.subfields[subfieldIndex].addMap(0, 1);
    productField.subfields[subfieldIndex].addMap(0, 15);
    productField.subfields[subfieldIndex].addMap(0, 13);
    productField.subfields[subfieldIndex].addMap(0, 89);
    subfieldIndex++;
    newMesg.setField(productField);
    fieldIndex++;
    newMesg.setField(
      Field("SerialNumber", 2, 140, 1.0, 0.0, "", false, ProfileType.uint32z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimeCreated", 3, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Completed", 4, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Type", 5, 0, 1.0, 0.0, "", false, ProfileType.schedule),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ScheduledTime",
        6,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.localDateTime,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createTotalsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Totals", MesgNum.totals);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimerTime", 0, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Distance", 1, 134, 1.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Calories", 2, 134, 1.0, 0.0, "kcal", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 3, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ElapsedTime", 4, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sessions", 5, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ActiveTime", 6, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SportIndex", 9, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createWeightScaleMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("WeightScale", MesgNum.weightScale);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Weight", 0, 132, 100.0, 0.0, "kg", false, ProfileType.weight),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PercentFat", 1, 132, 100.0, 0.0, "%", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "PercentHydration",
        2,
        132,
        100.0,
        0.0,
        "%",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "VisceralFatMass",
        3,
        132,
        100.0,
        0.0,
        "kg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BoneMass", 4, 132, 100.0, 0.0, "kg", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MuscleMass", 5, 132, 100.0, 0.0, "kg", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BasalMet",
        7,
        132,
        4.0,
        0.0,
        "kcal/day",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("PhysiqueRating", 8, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActiveMet",
        9,
        132,
        4.0,
        0.0,
        "kcal/day",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MetabolicAge", 10, 2, 1.0, 0.0, "years", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("VisceralFatRating", 11, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "UserProfileIndex",
        12,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Bmi", 13, 132, 10.0, 0.0, "kg/m^2", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createBloodPressureMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("BloodPressure", MesgNum.bloodPressure);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SystolicPressure",
        0,
        132,
        1.0,
        0.0,
        "mmHg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DiastolicPressure",
        1,
        132,
        1.0,
        0.0,
        "mmHg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MeanArterialPressure",
        2,
        132,
        1.0,
        0.0,
        "mmHg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Map3SampleMean",
        3,
        132,
        1.0,
        0.0,
        "mmHg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MapMorningValues",
        4,
        132,
        1.0,
        0.0,
        "mmHg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MapEveningValues",
        5,
        132,
        1.0,
        0.0,
        "mmHg",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HeartRate", 6, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HeartRateType", 7, 0, 1.0, 0.0, "", false, ProfileType.hrType),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Status", 8, 0, 1.0, 0.0, "", false, ProfileType.bpStatus),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "UserProfileIndex",
        9,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMonitoringInfoMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("MonitoringInfo", MesgNum.monitoringInfo);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LocalTimestamp",
        0,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.localDateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityType",
        1,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.activityType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CyclesToDistance",
        3,
        132,
        5000.0,
        0.0,
        "m/cycle",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CyclesToCalories",
        4,
        132,
        5000.0,
        0.0,
        "kcal/cycle",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RestingMetabolicRate",
        5,
        132,
        1.0,
        0.0,
        "kcal / day",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMonitoringMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Monitoring", MesgNum.monitoring);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceIndex", 0, 2, 1.0, 0.0, "", false, ProfileType.deviceIndex),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Calories", 1, 132, 1.0, 0.0, "kcal", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Distance", 2, 134, 100.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    final Field cyclesField = Field(
      "Cycles",
      3,
      134,
      2.0,
      0.0,
      "cycles",
      false,
      ProfileType.uint32,
    );
    subfieldIndex = 0;
    cyclesField.subfields.add(Subfield("Steps", 134, 1.0, 0.0, "steps"));
    cyclesField.subfields[subfieldIndex].addMap(5, 6);
    cyclesField.subfields[subfieldIndex].addMap(5, 1);
    subfieldIndex++;
    cyclesField.subfields.add(Subfield("Strokes", 134, 2.0, 0.0, "strokes"));
    cyclesField.subfields[subfieldIndex].addMap(5, 2);
    cyclesField.subfields[subfieldIndex].addMap(5, 5);
    subfieldIndex++;
    newMesg.setField(cyclesField);
    fieldIndex++;
    newMesg.setField(
      Field("ActiveTime", 4, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityType",
        5,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.activityType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivitySubtype",
        6,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.activitySubtype,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityLevel",
        7,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.activityLevel,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Distance16",
        8,
        132,
        1.0,
        0.0,
        "100 * m",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Cycles16",
        9,
        132,
        1.0,
        0.0,
        "2 * cycles (steps)",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ActiveTime16", 10, 132, 1.0, 0.0, "s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LocalTimestamp",
        11,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.localDateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Temperature", 12, 131, 100.0, 0.0, "C", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TemperatureMin",
        14,
        131,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TemperatureMax",
        15,
        131,
        100.0,
        0.0,
        "C",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActivityTime",
        16,
        132,
        1.0,
        0.0,
        "minutes",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ActiveCalories",
        19,
        132,
        1.0,
        0.0,
        "kcal",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    final Field currentActivityTypeIntensityField = Field(
      "CurrentActivityTypeIntensity",
      24,
      13,
      1.0,
      0.0,
      "",
      false,
      ProfileType.byte,
    );
    currentActivityTypeIntensityField.components.add(
      FieldComponent(5, false, 5, 1.0, 0.0),
    ); // activity_type
    currentActivityTypeIntensityField.components.add(
      FieldComponent(28, false, 3, 1.0, 0.0),
    ); // intensity
    newMesg.setField(currentActivityTypeIntensityField);
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMin8", 25, 2, 1.0, 0.0, "min", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp16", 26, 132, 1.0, 0.0, "s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HeartRate", 27, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Intensity", 28, 2, 10.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DurationMin", 29, 132, 1.0, 0.0, "min", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Duration", 30, 134, 1.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Ascent", 31, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Descent", 32, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ModerateActivityMinutes",
        33,
        132,
        1.0,
        0.0,
        "minutes",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "VigorousActivityMinutes",
        34,
        132,
        1.0,
        0.0,
        "minutes",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMonitoringHrDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("MonitoringHrData", MesgNum.monitoringHrData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RestingHeartRate",
        0,
        2,
        1.0,
        0.0,
        "bpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "CurrentDayRestingHeartRate",
        1,
        2,
        1.0,
        0.0,
        "bpm",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSpo2DataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Spo2Data", MesgNum.spo2Data);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ReadingSpo2", 0, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ReadingConfidence", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Mode", 2, 0, 1.0, 0.0, "", false, ProfileType.spo2MeasurementType),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHrMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Hr", MesgNum.hr);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FractionalTimestamp",
        0,
        132,
        32768.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    final Field time256Field = Field(
      "Time256",
      1,
      2,
      256.0,
      0.0,
      "s",
      false,
      ProfileType.uint8,
    );
    time256Field.components.add(
      FieldComponent(0, false, 8, 256.0, 0.0),
    ); // fractional_timestamp
    newMesg.setField(time256Field);
    fieldIndex++;
    newMesg.setField(
      Field("FilteredBpm", 6, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EventTimestamp",
        9,
        134,
        1024.0,
        0.0,
        "s",
        true,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    final Field eventTimestamp12Field = Field(
      "EventTimestamp12",
      10,
      13,
      1.0,
      0.0,
      "",
      false,
      ProfileType.byte,
    );
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    eventTimestamp12Field.components.add(
      FieldComponent(9, true, 12, 1024.0, 0.0),
    ); // event_timestamp
    newMesg.setField(eventTimestamp12Field);
    fieldIndex++;

    return newMesg;
  }

  static Mesg createStressLevelMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("StressLevel", MesgNum.stressLevel);
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "StressLevelValue",
        0,
        131,
        1.0,
        0.0,
        "",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StressLevelTime",
        1,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.dateTime,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMaxMetDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("MaxMetData", MesgNum.maxMetData);
    fieldIndex = 0;
    newMesg.setField(
      Field("UpdateTime", 0, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Vo2Max",
        2,
        132,
        10.0,
        0.0,
        "mL/kg/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sport", 5, 0, 1.0, 0.0, "", false, ProfileType.sport),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SubSport", 6, 0, 1.0, 0.0, "", false, ProfileType.subSport),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxMetCategory",
        8,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.maxMetCategory,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("CalibratedData", 9, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "HrSource",
        12,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.maxMetHeartRateSource,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SpeedSource",
        13,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.maxMetSpeedSource,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaBodyBatteryDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaBodyBatteryData", MesgNum.hsaBodyBatteryData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProcessingInterval",
        0,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Level", 1, 1, 1.0, 0.0, "percent", false, ProfileType.sint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Charged", 2, 131, 1.0, 0.0, "", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Uncharged", 3, 131, 1.0, 0.0, "", false, ProfileType.sint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaEventMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaEvent", MesgNum.hsaEvent);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EventId", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaAccelerometerDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "HsaAccelerometerData",
      MesgNum.hsaAccelerometerData,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SamplingInterval",
        1,
        132,
        1.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AccelX", 2, 131, 1.024, 0.0, "mG", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AccelY", 3, 131, 1.024, 0.0, "mG", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AccelZ", 4, 131, 1.024, 0.0, "mG", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp32k", 5, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaGyroscopeDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaGyroscopeData", MesgNum.hsaGyroscopeData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SamplingInterval",
        1,
        132,
        1.0,
        0.0,
        "1/32768 s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GyroX", 2, 131, 28.57143, 0.0, "deg/s", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GyroY", 3, 131, 28.57143, 0.0, "deg/s", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GyroZ", 4, 131, 28.57143, 0.0, "deg/s", false, ProfileType.sint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Timestamp32k",
        5,
        134,
        1.0,
        0.0,
        "1/32768 s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaStepDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaStepData", MesgNum.hsaStepData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProcessingInterval",
        0,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Steps", 1, 134, 1.0, 0.0, "steps", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaSpo2DataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaSpo2Data", MesgNum.hsaSpo2Data);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProcessingInterval",
        0,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ReadingSpo2", 1, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Confidence", 2, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaStressDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaStressData", MesgNum.hsaStressData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProcessingInterval",
        0,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StressLevel", 1, 1, 1.0, 0.0, "s", false, ProfileType.sint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaRespirationDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaRespirationData", MesgNum.hsaRespirationData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProcessingInterval",
        0,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RespirationRate",
        1,
        131,
        100.0,
        0.0,
        "breaths/min",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaHeartRateDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HsaHeartRateData", MesgNum.hsaHeartRateData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProcessingInterval",
        0,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Status", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HeartRate", 2, 2, 1.0, 0.0, "bpm", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaConfigurationDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "HsaConfigurationData",
      MesgNum.hsaConfigurationData,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Data", 0, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DataSize", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHsaWristTemperatureDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "HsaWristTemperatureData",
      MesgNum.hsaWristTemperatureData,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProcessingInterval",
        0,
        132,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Value", 1, 132, 1000.0, 0.0, "degC", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createMemoGlobMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("MemoGlob", MesgNum.memoGlob);
    fieldIndex = 0;
    newMesg.setField(
      Field("PartIndex", 250, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Memo", 0, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MesgNum", 1, 132, 1.0, 0.0, "", false, ProfileType.mesgNum),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ParentIndex",
        2,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FieldNum", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Data", 4, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSleepLevelMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SleepLevel", MesgNum.sleepLevel);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SleepLevel", 0, 0, 1.0, 0.0, "", false, ProfileType.sleepLevel),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createAntChannelIdMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("AntChannelId", MesgNum.antChannelId);
    fieldIndex = 0;
    newMesg.setField(
      Field("ChannelNumber", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceType", 1, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceNumber", 2, 139, 1.0, 0.0, "", false, ProfileType.uint16z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TransmissionType", 3, 10, 1.0, 0.0, "", false, ProfileType.uint8z),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeviceIndex", 4, 2, 1.0, 0.0, "", false, ProfileType.deviceIndex),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createAntRxMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("AntRx", MesgNum.antRx);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FractionalTimestamp",
        0,
        132,
        32768.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MesgId", 1, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    final Field mesgDataField = Field(
      "MesgData",
      2,
      13,
      1.0,
      0.0,
      "",
      false,
      ProfileType.byte,
    );
    mesgDataField.components.add(
      FieldComponent(3, false, 8, 1.0, 0.0),
    ); // channel_number
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    newMesg.setField(mesgDataField);
    fieldIndex++;
    newMesg.setField(
      Field("ChannelNumber", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Data", 4, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createAntTxMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("AntTx", MesgNum.antTx);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "FractionalTimestamp",
        0,
        132,
        32768.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MesgId", 1, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;
    final Field mesgDataField = Field(
      "MesgData",
      2,
      13,
      1.0,
      0.0,
      "",
      false,
      ProfileType.byte,
    );
    mesgDataField.components.add(
      FieldComponent(3, false, 8, 1.0, 0.0),
    ); // channel_number
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    mesgDataField.components.add(FieldComponent(4, false, 8, 1.0, 0.0)); // data
    newMesg.setField(mesgDataField);
    fieldIndex++;
    newMesg.setField(
      Field("ChannelNumber", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Data", 4, 13, 1.0, 0.0, "", false, ProfileType.byte),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createExdScreenConfigurationMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "ExdScreenConfiguration",
      MesgNum.exdScreenConfiguration,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("ScreenIndex", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("FieldCount", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Layout", 2, 0, 1.0, 0.0, "", false, ProfileType.exdLayout),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ScreenEnabled", 3, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createExdDataFieldConfigurationMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "ExdDataFieldConfiguration",
      MesgNum.exdDataFieldConfiguration,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("ScreenIndex", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    final Field conceptFieldField = Field(
      "ConceptField",
      1,
      13,
      1.0,
      0.0,
      "",
      false,
      ProfileType.byte,
    );
    conceptFieldField.components.add(
      FieldComponent(2, false, 4, 1.0, 0.0),
    ); // field_id
    conceptFieldField.components.add(
      FieldComponent(3, false, 4, 1.0, 0.0),
    ); // concept_count
    newMesg.setField(conceptFieldField);
    fieldIndex++;
    newMesg.setField(
      Field("FieldId", 2, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ConceptCount", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DisplayType",
        4,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.exdDisplayType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Title", 5, 7, 1.0, 0.0, "", false, ProfileType.string),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createExdDataConceptConfigurationMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "ExdDataConceptConfiguration",
      MesgNum.exdDataConceptConfiguration,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("ScreenIndex", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    final Field conceptFieldField = Field(
      "ConceptField",
      1,
      13,
      1.0,
      0.0,
      "",
      false,
      ProfileType.byte,
    );
    conceptFieldField.components.add(
      FieldComponent(2, false, 4, 1.0, 0.0),
    ); // field_id
    conceptFieldField.components.add(
      FieldComponent(3, false, 4, 1.0, 0.0),
    ); // concept_index
    newMesg.setField(conceptFieldField);
    fieldIndex++;
    newMesg.setField(
      Field("FieldId", 2, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ConceptIndex", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DataPage", 4, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ConceptKey", 5, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Scaling", 6, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DataUnits", 8, 0, 1.0, 0.0, "", false, ProfileType.exdDataUnits),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Qualifier", 9, 0, 1.0, 0.0, "", false, ProfileType.exdQualifiers),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Descriptor",
        10,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.exdDescriptors,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("IsSigned", 11, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createDiveSummaryMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("DiveSummary", MesgNum.diveSummary);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ReferenceMesg", 0, 132, 1.0, 0.0, "", false, ProfileType.mesgNum),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ReferenceIndex",
        1,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgDepth", 2, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxDepth", 3, 134, 1000.0, 0.0, "m", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SurfaceInterval",
        4,
        134,
        1.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartCns", 5, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndCns", 6, 2, 1.0, 0.0, "percent", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("StartN2", 7, 132, 1.0, 0.0, "percent", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EndN2", 8, 132, 1.0, 0.0, "percent", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("O2Toxicity", 9, 132, 1.0, 0.0, "OTUs", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DiveNumber", 10, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("BottomTime", 11, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgPressureSac",
        12,
        132,
        100.0,
        0.0,
        "bar/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgVolumeSac",
        13,
        132,
        100.0,
        0.0,
        "L/min",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgRmv", 14, 132, 100.0, 0.0, "L/min", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "DescentTime",
        15,
        134,
        1000.0,
        0.0,
        "s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AscentTime", 16, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgAscentRate",
        17,
        133,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.sint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AvgDescentRate",
        22,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxAscentRate",
        23,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "MaxDescentRate",
        24,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("HangTime", 25, 134, 1000.0, 0.0, "s", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createAadAccelFeaturesMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("AadAccelFeatures", MesgNum.aadAccelFeatures);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Time", 0, 132, 1.0, 0.0, "s", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("EnergyTotal", 1, 134, 1.0, 0.0, "", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ZeroCrossCnt", 2, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Instance", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "TimeAboveThreshold",
        4,
        132,
        25.0,
        0.0,
        "s",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHrvMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Hrv", MesgNum.hrv);
    fieldIndex = 0;
    newMesg.setField(
      Field("Time", 0, 132, 1000.0, 0.0, "s", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createBeatIntervalsMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("BeatIntervals", MesgNum.beatIntervals);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Time", 1, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHrvStatusSummaryMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HrvStatusSummary", MesgNum.hrvStatusSummary);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "WeeklyAverage",
        0,
        132,
        128.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LastNightAverage",
        1,
        132,
        128.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LastNight5MinHigh",
        2,
        132,
        128.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BaselineLowUpper",
        3,
        132,
        128.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BaselineBalancedLower",
        4,
        132,
        128.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "BaselineBalancedUpper",
        5,
        132,
        128.0,
        0.0,
        "ms",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Status", 6, 0, 1.0, 0.0, "", false, ProfileType.hrvStatus),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createHrvValueMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("HrvValue", MesgNum.hrvValue);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Value", 0, 132, 128.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createRawBbiMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("RawBbi", MesgNum.rawBbi);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("TimestampMs", 0, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    final Field dataField = Field(
      "Data",
      1,
      132,
      1.0,
      0.0,
      "",
      false,
      ProfileType.uint16,
    );
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    dataField.components.add(FieldComponent(2, false, 14, 1.0, 0.0)); // time
    dataField.components.add(FieldComponent(3, false, 1, 1.0, 0.0)); // quality
    dataField.components.add(FieldComponent(4, false, 1, 1.0, 0.0)); // gap
    newMesg.setField(dataField);
    fieldIndex++;
    newMesg.setField(
      Field("Time", 2, 132, 1.0, 0.0, "ms", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Quality", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Gap", 4, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createRespirationRateMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("RespirationRate", MesgNum.respirationRate);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "RespirationRate",
        0,
        131,
        100.0,
        0.0,
        "breaths/min",
        false,
        ProfileType.sint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createChronoShotSessionMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("ChronoShotSession", MesgNum.chronoShotSession);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MinSpeed", 0, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("MaxSpeed", 1, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AvgSpeed", 2, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ShotCount", 3, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "ProjectileType",
        4,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.projectileType,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("GrainWeight", 5, 134, 10.0, 0.0, "gr", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StandardDeviation",
        6,
        134,
        1000.0,
        0.0,
        "m/s",
        false,
        ProfileType.uint32,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createChronoShotDataMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("ChronoShotData", MesgNum.chronoShotData);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ShotSpeed", 0, 134, 1000.0, 0.0, "m/s", false, ProfileType.uint32),
    );
    fieldIndex++;
    newMesg.setField(
      Field("ShotNum", 1, 132, 1.0, 0.0, "", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createTankUpdateMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("TankUpdate", MesgNum.tankUpdate);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sensor", 0, 140, 1.0, 0.0, "", false, ProfileType.antChannelId),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Pressure", 1, 132, 100.0, 0.0, "bar", false, ProfileType.uint16),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createTankSummaryMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("TankSummary", MesgNum.tankSummary);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "s", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Sensor", 0, 140, 1.0, 0.0, "", false, ProfileType.antChannelId),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "StartPressure",
        1,
        132,
        100.0,
        0.0,
        "bar",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "EndPressure",
        2,
        132,
        100.0,
        0.0,
        "bar",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("VolumeUsed", 3, 134, 100.0, 0.0, "L", false, ProfileType.uint32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSleepAssessmentMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SleepAssessment", MesgNum.sleepAssessment);
    fieldIndex = 0;
    newMesg.setField(
      Field("CombinedAwakeScore", 0, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AwakeTimeScore", 1, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AwakeningsCountScore",
        2,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("DeepSleepScore", 3, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SleepDurationScore", 4, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("LightSleepScore", 5, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("OverallSleepScore", 6, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SleepQualityScore", 7, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("SleepRecoveryScore", 8, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field("RemSleepScore", 9, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "SleepRestlessnessScore",
        10,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("AwakeningsCount", 11, 2, 1.0, 0.0, "", false, ProfileType.uint8),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "InterruptionsScore",
        14,
        2,
        1.0,
        0.0,
        "",
        false,
        ProfileType.uint8,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AverageStressDuringSleep",
        15,
        132,
        100.0,
        0.0,
        "",
        false,
        ProfileType.uint16,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSleepDisruptionSeverityPeriodMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "SleepDisruptionSeverityPeriod",
      MesgNum.sleepDisruptionSeverityPeriod,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field(
        "MessageIndex",
        254,
        132,
        1.0,
        0.0,
        "",
        false,
        ProfileType.messageIndex,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Severity",
        0,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.sleepDisruptionSeverity,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSleepDisruptionOvernightSeverityMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg(
      "SleepDisruptionOvernightSeverity",
      MesgNum.sleepDisruptionOvernightSeverity,
    );
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Severity",
        0,
        0,
        1.0,
        0.0,
        "",
        false,
        ProfileType.sleepDisruptionSeverity,
      ),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createSkinTempOvernightMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("SkinTempOvernight", MesgNum.skinTempOvernight);
    fieldIndex = 0;
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "LocalTimestamp",
        0,
        134,
        1.0,
        0.0,
        "",
        false,
        ProfileType.localDateTime,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "AverageDeviation",
        1,
        136,
        1.0,
        0.0,
        "",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field(
        "Average7DayDeviation",
        2,
        136,
        1.0,
        0.0,
        "",
        false,
        ProfileType.float32,
      ),
    );
    fieldIndex++;
    newMesg.setField(
      Field("NightlyValue", 4, 136, 1.0, 0.0, "", false, ProfileType.float32),
    );
    fieldIndex++;

    return newMesg;
  }

  static Mesg createPadMesg() {
    int fieldIndex, subfieldIndex;
    final Mesg newMesg = Mesg("Pad", MesgNum.pad);
    fieldIndex = 0;

    return newMesg;
  }

  static Mesg createNapEventMesg() {
    final Mesg newMesg = Mesg("NapEvent", MesgNum.napEvent);
    newMesg.setField(
      Field("MessageIndex", 254, 132, 1.0, 0.0, "", false,
          ProfileType.messageIndex),
    );
    newMesg.setField(
      Field("Timestamp", 253, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    newMesg.setField(
      Field("StartTime", 0, 134, 1.0, 0.0, "seconds", false,
          ProfileType.dateTime),
    );
    newMesg.setField(
      Field("StartTimezoneOffset", 1, 131, 1.0, 0.0, "minutes", false,
          ProfileType.sint16),
    );
    newMesg.setField(
      Field(
          "EndTime", 2, 134, 1.0, 0.0, "seconds", false, ProfileType.dateTime),
    );
    newMesg.setField(
      Field("EndTimezoneOffset", 3, 131, 1.0, 0.0, "minutes", false,
          ProfileType.sint16),
    );
    newMesg.setField(
      Field(
          "Feedback", 4, 0, 1.0, 0.0, "", false, ProfileType.napPeriodFeedback),
    );
    newMesg.setField(
      Field("IsDeleted", 5, 0, 1.0, 0.0, "", false, ProfileType.bool_),
    );
    newMesg.setField(
      Field("Source", 6, 0, 1.0, 0.0, "", false, ProfileType.napSource),
    );
    newMesg.setField(
      Field(
          "UpdateTimestamp", 7, 134, 1.0, 0.0, "", false, ProfileType.dateTime),
    );
    return newMesg;
  }
}
