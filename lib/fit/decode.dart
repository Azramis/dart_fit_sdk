import 'dart:typed_data';
import 'profile.dart';
import 'profile/types/mesg_num.dart';
import 'developer_data_lookup.dart';
import 'developer_field_description.dart';
import 'profile/mesgs/developer_data_id_mesg.dart';
import 'profile/mesgs/field_description_mesg.dart';
import 'profile/mesgs/record_mesg.dart';
import 'field.dart';
import 'crc.dart';
import 'fit_exception.dart';
import '../utility/endian_binary_reader.dart';
import 'header.dart';
import 'mesg_definition.dart';
import 'mesg.dart';
import 'defines.dart';
import 'accumulator.dart';

enum DecodeMode { normal, invalidHeader, dataOnly }

class Decode {
  final Map<int, MesgDefinition> _localMesgDefinitions = {};
  final Accumulator _accumulator = Accumulator();
  final DeveloperDataLookup _lookup = DeveloperDataLookup();

  int _timestamp = 0;
  int _lastTimeOffset = 0;

  void Function(MesgDefinition)? onMesgDefinition;
  void Function(Mesg)? onMesg;
  void Function(DeveloperFieldDescription)? onDeveloperFieldDescription;

  void read(Uint8List data, {DecodeMode mode = DecodeMode.normal}) {
    final EndianBinaryReader reader = EndianBinaryReader(data);

    if (mode == DecodeMode.normal || mode == DecodeMode.invalidHeader) {
      final Header header = Header();
      try {
        header.read(reader);
      } catch (e) {
        if (mode == DecodeMode.normal) rethrow;
      }

      if (mode == DecodeMode.normal) {
        // CRC Check
        final int calculatedCrc = Crc.calc16(data, data.length - 2);
        final int fileCrc = data[data.length - 2] | (data[data.length - 1] << 8);
        if (calculatedCrc != fileCrc) {
          throw FitException('FIT decode error: File CRC mismatch');
        }
      }
    }

    while (reader.position < reader.length - 2) {
      final int headerByte = reader.readByte();

      if ((headerByte & Fit.mesgDefinitionMask) == Fit.mesgDefinitionMask) {
        // Message Definition
        reader.position--; // Back up to read full definition
        final MesgDefinition mesgDef = MesgDefinition();
        mesgDef.read(reader, lookup: _lookup);
        _localMesgDefinitions[mesgDef.localMesgNum] = mesgDef;
        onMesgDefinition?.call(mesgDef);
      } else if ((headerByte & Fit.compressedHeaderMask) ==
          Fit.compressedHeaderMask) {
        // Compressed Timestamp Header
        final int timeOffset = headerByte & Fit.compressedTimeMask;
        _timestamp += (timeOffset - _lastTimeOffset) & Fit.compressedTimeMask;
        _lastTimeOffset = timeOffset;

        final int localMesgNum = (headerByte & Fit.compressedLocalMesgNumMask) >> 5;
        final MesgDefinition? def = _localMesgDefinitions[localMesgNum];
        if (def != null) {
          final Mesg newMesg = Mesg.fromDefinition(def);
          newMesg.read(reader, def);

          // Add Timestamp Field
          final Mesg recordMesg = Profile.getMesg(MesgNum.record);
          final Field? timestampProfileField =
              recordMesg.getField(RecordMesg.fieldTimestamp);
          if (timestampProfileField != null) {
            final Field timestampField = Field.fromOther(timestampProfileField);
            timestampField.setValue(_timestamp);
            newMesg.insertField(0, timestampField);
          }

          newMesg.expandComponents(_accumulator);
          _handleMetaData(newMesg);
          onMesg?.call(newMesg);
        }
      } else {
        // Data Message
        final int localMesgNum = headerByte & Fit.localMesgNumMask;
        final MesgDefinition? def = _localMesgDefinitions[localMesgNum];
        if (def != null) {
          final Mesg newMesg = Mesg.fromDefinition(def);
          newMesg.read(reader, def);

          // The reference for compressed timestamp headers. Looked up by name,
          // as in the C# SDK: Set and CoursePoint keep theirs outside field 253.
          final Field? timestampField = newMesg.getFieldByName('Timestamp');
          if (timestampField != null) {
            final Object? val = timestampField.value;
            if (val is int) {
              _timestamp = val;
              _lastTimeOffset = _timestamp & Fit.compressedTimeMask;
            }
          }

          // Accumulate fields
          for (var field in newMesg.fields) {
            if (field.isAccumulated) {
              for (int i = 0; i < field.getNumValues(); i++) {
                final val = field.values[i];
                if (val is! num) continue;
                int value = val.toInt();

                for (var fieldIn in newMesg.fields) {
                  for (var fc in fieldIn.components) {
                    if (fc.fieldNum == field.num && fc.accumulate) {
                      value = ((((value / field.scale) - field.offset) +
                                  fc.offset) *
                              fc.scale)
                          .round();
                    }
                  }
                }
                _accumulator.set(newMesg.num, field.num, value);
              }
            }
          }

          newMesg.expandComponents(_accumulator);
          _handleMetaData(newMesg);
          onMesg?.call(newMesg);
        } else {
          // Should not happen if FIT is valid
          break;
        }
      }
    }
  }

  void _handleMetaData(Mesg newMesg) {
    if (newMesg.num == MesgNum.developerDataId) {
      final mesg = DeveloperDataIdMesg.fromMesg(newMesg);
      _lookup.addIdMesg(mesg);
    } else if (newMesg.num == MesgNum.fieldDescription) {
      final mesg = FieldDescriptionMesg.fromMesg(newMesg);
      final desc = _lookup.addDescriptionMesg(mesg);
      if (desc != null) {
        onDeveloperFieldDescription?.call(desc);
      }
    }
  }
}
