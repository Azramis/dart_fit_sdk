#!/usr/bin/env python3
"""
Generate lib/fit/profile/types/enum_registries.dart
from the existing static-const type files.

Usage:
  python3 /tmp/gen_enum_registries.py <repo_root>
"""

import os
import re
import sys

REPO_ROOT = sys.argv[1] if len(sys.argv) > 1 else '/home/runner/work/dart_fit_sdk/dart_fit_sdk'
TYPES_DIR = os.path.join(REPO_ROOT, 'lib/fit/profile/types')
OUT_FILE = os.path.join(TYPES_DIR, 'enum_registries.dart')

# Base / scalar ProfileType names that have no meaningful named enum values.
# These are excluded from the registry (enumType() returns null for them).
BASE_TYPES = {
    'enum_', 'sint8', 'uint8', 'sint16', 'uint16', 'sint32', 'uint32',
    'string', 'float32', 'float64', 'uint8z', 'uint16z', 'uint32z',
    'byte', 'sint64', 'uint64', 'uint64z', 'bool_',
    # Scalar specials — single sentinel values, not named enums
    'dateTime', 'localDateTime', 'messageIndex', 'deviceIndex',
    'mesgNum', 'mesgCount', 'checksum',
    # Bit-field / mask types
    'userLocalId', 'localtimeIntoDay', 'timeIntoDay',
    'leftRightBalance', 'leftRightBalance100',
    'activityClass',
}

# ProfileType names to skip entirely (not real types)
SKIP_TYPES = {'numTypes'}

# Class name overrides: profileTypeName -> className
CLASS_NAME_OVERRIDES = {
    'dateTime': 'FitDateTime',
    'switch_': 'Switch',
    'enum_': 'Enum',
    'bool_': 'Bool',
    'set_': 'Set',
}

# File name overrides: profileTypeName -> fileName (without .dart)
FILE_NAME_OVERRIDES = {
    'localtimeIntoDay': 'localtime_into_day',
    'antChannelId': 'ant_channel_id',
}

def to_class_name(profile_type_name):
    ovr = CLASS_NAME_OVERRIDES.get(profile_type_name)
    if ovr:
        return ovr
    if not profile_type_name:
        return profile_type_name
    return profile_type_name[0].upper() + profile_type_name[1:]

def to_file_name(class_name):
    """PascalCase -> snake_case (with underscore before trailing digits)"""
    s = re.sub(r'([A-Z]+)([A-Z][a-z])', r'\1_\2', class_name)
    s = re.sub(r'([a-z0-9])([A-Z])', r'\1_\2', s)
    # Add underscore before trailing digit group (e.g. bits0 -> bits_0)
    s = re.sub(r'([a-z])(\d+)$', r'\1_\2', s)
    return s.lower()

def parse_constants(source, class_name):
    """Parse static const int fields from a class body."""
    result = {}
    # Find the class body
    class_re = re.compile(
        r'class\s+' + re.escape(class_name) + r'\s*\{([\s\S]*?)\}(?=\s*(?:class|\Z))',
        re.MULTILINE
    )
    m = class_re.search(source)
    if not m:
        return result
    body = m.group(1)
    const_re = re.compile(
        r'static\s+const\s+int\s+(\w+)\s*=\s*(0x[0-9a-fA-F]+|-?\d+)\s*;'
    )
    for cm in const_re.finditer(body):
        name = cm.group(1)
        val_str = cm.group(2)
        if val_str.startswith('0x'):
            value = int(val_str[2:], 16)
        else:
            value = int(val_str)
        result[name] = value
    return result

# All ProfileType enum names in order (from profile.dart)
ALL_PROFILE_TYPES = [
    'enum_', 'sint8', 'uint8', 'sint16', 'uint16', 'sint32', 'uint32',
    'string', 'float32', 'float64', 'uint8z', 'uint16z', 'uint32z',
    'byte', 'sint64', 'uint64', 'uint64z', 'bool_',
    'file', 'mesgNum', 'checksum', 'fileFlags', 'mesgCount',
    'dateTime', 'localDateTime', 'messageIndex', 'deviceIndex',
    'gender', 'language',
    'languageBits0', 'languageBits1', 'languageBits2', 'languageBits3', 'languageBits4',
    'timeZone', 'displayMeasure', 'displayHeart', 'displayPower', 'displayPosition',
    'switch_', 'sport',
    'sportBits0', 'sportBits1', 'sportBits2', 'sportBits3', 'sportBits4', 'sportBits5', 'sportBits6',
    'subSport', 'sportEvent', 'activity', 'intensity', 'sessionTrigger',
    'autolapTrigger', 'lapTrigger', 'timeMode', 'backlightMode', 'dateMode',
    'backlightTimeout', 'event', 'eventType', 'timerTrigger', 'fitnessEquipmentState',
    'tone', 'autoscroll', 'activityClass', 'hrZoneCalc', 'pwrZoneCalc',
    'wktStepDuration', 'wktStepTarget', 'goal', 'goalRecurrence', 'goalSource',
    'schedule', 'coursePoint', 'manufacturer', 'garminProduct', 'antplusDeviceType',
    'antNetwork', 'workoutCapabilities', 'batteryStatus', 'hrType',
    'courseCapabilities', 'weight', 'workoutHr', 'workoutPower', 'bpStatus',
    'userLocalId', 'swimStroke', 'activityType', 'activitySubtype', 'activityLevel',
    'side', 'leftRightBalance', 'leftRightBalance100', 'lengthType', 'dayOfWeek',
    'connectivityCapabilities', 'weatherReport', 'weatherStatus', 'weatherSeverity',
    'weatherSevereType', 'timeIntoDay', 'localtimeIntoDay', 'strokeType', 'bodyLocation',
    'segmentLapStatus', 'segmentLeaderboardType', 'segmentDeleteStatus',
    'segmentSelectionType', 'sourceType', 'localDeviceType', 'bleDeviceType',
    'antChannelId', 'displayOrientation', 'workoutEquipment', 'watchfaceMode',
    'digitalWatchfaceLayout', 'analogWatchfaceLayout', 'riderPositionType',
    'powerPhaseType', 'cameraEventType', 'sensorType', 'bikeLightNetworkConfigType',
    'commTimeoutType', 'cameraOrientationType', 'attitudeStage', 'attitudeValidity',
    'autoSyncFrequency', 'exdLayout', 'exdDisplayType', 'exdDataUnits', 'exdQualifiers',
    'exdDescriptors', 'autoActivityDetect', 'supportedExdScreenLayouts', 'fitBaseType',
    'turnType', 'bikeLightBeamAngleMode', 'fitBaseUnit', 'setType', 'maxMetCategory',
    'exerciseCategory',
    'benchPressExerciseName', 'calfRaiseExerciseName', 'cardioExerciseName',
    'carryExerciseName', 'chopExerciseName', 'coreExerciseName', 'crunchExerciseName',
    'curlExerciseName', 'deadliftExerciseName', 'flyeExerciseName',
    'hipRaiseExerciseName', 'hipStabilityExerciseName', 'hipSwingExerciseName',
    'hyperextensionExerciseName', 'lateralRaiseExerciseName', 'legCurlExerciseName',
    'legRaiseExerciseName', 'lungeExerciseName', 'olympicLiftExerciseName',
    'plankExerciseName', 'plyoExerciseName', 'pullUpExerciseName',
    'pushUpExerciseName', 'rowExerciseName', 'shoulderPressExerciseName',
    'shoulderStabilityExerciseName', 'shrugExerciseName', 'sitUpExerciseName',
    'squatExerciseName',
    'totalBodyExerciseName', 'moveExerciseName', 'poseExerciseName',
    'tricepsExtensionExerciseName', 'warmUpExerciseName', 'runExerciseName',
    'bikeExerciseName', 'bandedExercisesExerciseName', 'battleRopeExerciseName',
    'ellipticalExerciseName', 'floorClimbExerciseName', 'indoorBikeExerciseName',
    'indoorRowExerciseName', 'ladderExerciseName', 'sandbagExerciseName',
    'sledExerciseName', 'sledgeHammerExerciseName', 'stairStepperExerciseName',
    'suspensionExerciseName', 'tireExerciseName', 'bikeOutdoorExerciseName',
    'runIndoorExerciseName',
    'waterType', 'tissueModelType', 'diveGasStatus', 'diveAlert', 'diveAlarmType',
    'diveBacklightMode', 'sleepLevel', 'spo2MeasurementType', 'ccrSetpointSwitchMode',
    'diveGasMode', 'projectileType', 'faveroProduct', 'splitType', 'climbProEvent',
    'gasConsumptionRateType', 'tapSensitivity', 'radarThreatLevelType',
    'sleepDisruptionSeverity', 'maxMetSpeedSource', 'maxMetHeartRateSource',
    'hrvStatus', 'noFlyTimeMode',
    'numTypes', 'napPeriodFeedback', 'napSource',
]

lines = []
lines.append('// AUTO-GENERATED by tool/generate_enum_registries.dart')
lines.append('// Do not edit by hand — regenerate whenever the profile types change.')
lines.append('//')
lines.append('// Maps each named ProfileType to its { value -> name } registry.')
lines.append('// Base/scalar types are omitted (they have no named enum values).')
lines.append('')
lines.append("import '../../profile.dart' show ProfileType;")
lines.append('')
lines.append('/// Maps each named [ProfileType] to its integer-value → member-name table.')
lines.append('///')
lines.append('/// Only "true" enum types (those with named values) are present;')
lines.append('/// base numeric/scalar types are absent (their entry is not in this map).')
lines.append('const Map<ProfileType, Map<int, String>> kProfileTypeValues = {')

emitted = 0
skipped = 0

for pt_name in ALL_PROFILE_TYPES:
    if pt_name in SKIP_TYPES:
        continue
    if pt_name in BASE_TYPES:
        continue

    class_name = to_class_name(pt_name)
    file_name = FILE_NAME_OVERRIDES.get(pt_name) or to_file_name(class_name)
    type_file = os.path.join(TYPES_DIR, f'{file_name}.dart')

    if not os.path.exists(type_file):
        print(f'  MISSING: {pt_name} -> {file_name}.dart', file=sys.stderr)
        skipped += 1
        continue

    with open(type_file, 'r') as f:
        source = f.read()

    constants = parse_constants(source, class_name)
    if not constants:
        print(f'  EMPTY: {pt_name} ({class_name} in {file_name}.dart)', file=sys.stderr)
        skipped += 1
        continue

    lines.append(f'  ProfileType.{pt_name}: {{')
    for name, value in constants.items():
        lines.append(f"    {value}: '{name}',")
    lines.append('  },')
    emitted += 1

lines.append('};')
lines.append('')

output = '\n'.join(lines)
with open(OUT_FILE, 'w') as f:
    f.write(output)

print(f'Generated {OUT_FILE}', file=sys.stderr)
print(f'{emitted} enum types emitted, {skipped} skipped.', file=sys.stderr)
