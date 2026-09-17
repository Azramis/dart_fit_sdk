import 'dart:typed_data';
import 'dart:convert';
import 'field.dart';
import 'mesg_definition.dart';
import 'defines.dart';
import 'profile.dart';
import 'accumulator.dart';
import 'developer_field.dart';
import 'developer_data_key.dart';
import 'field_base.dart';
import 'field_component.dart';
import 'subfield.dart';
import '../utility/endian_binary_reader.dart';
import '../utility/endian_binary_writer.dart';
import 'fit_exception.dart';

class Mesg {
  String name;
  int num;
  int _localNum = 0;

  int get localNum => _localNum;
  set localNum(int value) {
    if (value > Fit.localMesgNumMask) {
      throw FitException('Mesg:localNum - Invalid Local message number $value');
    }
    _localNum = value;
  }

  final List<Field> fields = [];
  final Map<DeveloperDataKey, DeveloperField> _developerFields = {};

  Iterable<DeveloperField> get developerFields => _developerFields.values;

  Mesg(this.name, this.num);

  Mesg.from(Mesg other)
    : name = other.name,
      num = other.num,
      _localNum = other._localNum {
    for (var field in other.fields) {
      if (field.values.isNotEmpty) {
        fields.add(Field.fromOther(field));
      }
    }
    for (var devField in other.developerFields) {
      if (devField.values.isNotEmpty) {
        final key = DeveloperDataKey(devField.developerDataIndex, devField.num);
        _developerFields[key] = DeveloperField.fromOther(devField);
      }
    }
  }

  Mesg.fromMesgNum(int mesgNum) : this.from(Profile.getMesg(mesgNum));

  Mesg.fromDefinition(MesgDefinition def)
    : name = Profile.getMesg(def.globalMesgNum).name,
      num = def.globalMesgNum {
    localNum = def.localMesgNum;
    // Fields will be added during read
  }

  void read(EndianBinaryReader reader, MesgDefinition def) {
    localNum = def.localMesgNum;
    final bool originalEndian = reader.isBigEndian;
    reader.isBigEndian = def.isBigEndian;

    for (var fieldDef in def.getFields()) {
      bool shouldRead = true;
      Field? field = getField(fieldDef.num);
      if (field == null) {
        final Mesg profileMesg = Profile.getMesg(num);
        final Field? profileField = profileMesg.getField(fieldDef.num);
        if (profileField != null) {
          field = Field.fromOther(profileField);
        } else {
          field = Field(
            'unknown',
            fieldDef.num,
            fieldDef.type,
            1.0,
            0.0,
            '',
            false,
            ProfileType.uint8,
          );
        }
        setField(field);
      }

      if (field.type != fieldDef.type) {
        final int fieldSize = Fit.baseType[field.type & Fit.baseTypeNumMask].size;
        final int defSize = Fit.baseType[fieldDef.type & Fit.baseTypeNumMask].size;

        if (defSize < fieldSize) {
          field.type = fieldDef.type;
        } else if (defSize != fieldSize) {
          shouldRead = false;
        }
      }

      if (shouldRead) {
        _readFieldValue(field, fieldDef.size, reader);
      } else {
        reader.readBytes(fieldDef.size);
      }
    }

    for (var devFldDef in def.developerFieldDefinitions) {
      DeveloperField? fld = _getDeveloperField(
        devFldDef.fieldNum,
        devFldDef.developerDataIndex,
      );
      if (fld == null) {
        fld = DeveloperField(devFldDef);
        setDeveloperField(fld);
      }
      _readFieldValue(fld, devFldDef.size, reader);
    }

    reader.isBigEndian = originalEndian;
  }

  void _readFieldValue(FieldBase field, int size, EndianBinaryReader reader) {
    final int baseTypeNum = field.type & Fit.baseTypeNumMask;
    if (baseTypeNum == Fit.string) {
      final Uint8List bytes = reader.readBytes(size);
      final List<int> currentStringBytes = [];

      if (!bytes.any((b) => b != 0)) {
        return;
      }

      for (int b in bytes) {
        if (b == 0) {
          field.addValue(Uint8List.fromList(currentStringBytes));
          currentStringBytes.clear();
        } else {
          currentStringBytes.add(b);
        }
      }
      if (currentStringBytes.isNotEmpty) {
        currentStringBytes.add(0);
        field.addValue(Uint8List.fromList(currentStringBytes));
      }
    } else {
      final int baseTypeSize = Fit.baseType[baseTypeNum].size;
      final int numElements = size ~/ baseTypeSize;
      for (int i = 0; i < numElements; i++) {
        final Object? value = _readRawValue(field.type, reader);
        if (value != null || numElements > 1) {
          field.setRawValue(i, value);
        }
      }
    }
  }

  Object? _readRawValue(int type, EndianBinaryReader reader) {
    final int baseTypeNum = type & Fit.baseTypeNumMask;
    final invalid = Fit.baseType[baseTypeNum].invalidValue;
    Object? value;

    switch (baseTypeNum) {
      case Fit.enum_:
      case Fit.uint8:
      case Fit.uint8z:
      case Fit.byte:
        value = reader.readByte();
        break;
      case Fit.sint8:
        value = reader.readSByte();
        break;
      case Fit.sint16:
        value = reader.readInt16();
        break;
      case Fit.uint16:
      case Fit.uint16z:
        value = reader.readUInt16();
        break;
      case Fit.sint32:
        value = reader.readInt32();
        break;
      case Fit.uint32:
      case Fit.uint32z:
        value = reader.readUInt32();
        break;
      case Fit.float32:
        value = reader.readFloat32();
        break;
      case Fit.float64:
        value = reader.readFloat64();
        break;
      case Fit.sint64:
        value = reader.readSInt64();
        break;
      case Fit.uint64:
      case Fit.uint64z:
        value = reader.readUInt64();
        break;
      default:
        return null;
    }

    if (value == invalid) return null;
    return value;
  }

  void write(EndianBinaryWriter writer, [MesgDefinition? def]) {
    final MesgDefinition mesgDef = def ?? MesgDefinition.fromMesg(this);
    writer.writeByte(localNum);

    for (var fieldDef in mesgDef.getFields()) {
      Field? field = getField(fieldDef.num);
      if (field == null) {
        final Field? profileField = Profile.getMesg(num).getField(fieldDef.num);
        if (profileField != null) {
          field = Field.fromOther(profileField);
          fields.add(field);
        } else {
          field = Field(
            'unknown',
            fieldDef.num,
            fieldDef.type,
            1.0,
            0.0,
            '',
            false,
            ProfileType.uint8,
          );
        }
      }
      _writeField(field, fieldDef.size, writer);
    }

    for (var fieldDef in mesgDef.developerFieldDefinitions) {
      DeveloperField? field = _getDeveloperField(
        fieldDef.fieldNum,
        fieldDef.developerDataIndex,
      );
      if (field == null) {
        field = DeveloperField(fieldDef);
        setDeveloperField(field);
      }
      _writeField(field, fieldDef.size, writer);
    }
  }

  void _writeField(FieldBase field, int size, EndianBinaryWriter writer) {
    final int baseTypeNum = field.type & Fit.baseTypeNumMask;

    // Strings are special because getSize() is complex
    if (baseTypeNum == Fit.string) {
      final int currentSize = field.getSize();
      if (currentSize < size) {
        // We need to pad. For strings, we add null bytes to the last string or add a new empty string.
        final int padAmount = size - currentSize;
        if (field.getNumValues() == 0) {
          field.addValue(Uint8List(padAmount));
        } else {
          final lastVal = field.values.last;
          List<int> bytes = [];
          if (lastVal is String) {
            bytes = utf8.encode(lastVal);
          } else if (lastVal is List<int>) {
            bytes = List<int>.from(lastVal);
          }
          bytes.addAll(Iterable.generate(padAmount, (_) => 0));
          field.values[field.values.length - 1] = bytes;
        }
      }

      for (int i = 0; i < field.getNumValues(); i++) {
        _writeRawValue(field.type, field.values[i], writer);
      }
    } else {
      final int baseTypeSize = Fit.baseType[baseTypeNum].size;
      final int numValues = size ~/ baseTypeSize;

      for (int i = 0; i < numValues; i++) {
        final Object? value = i < field.getNumValues() ? field.values[i] : null;
        _writeRawValue(field.type, value, writer);
      }
    }
  }

  void _writeRawValue(int type, Object? value, EndianBinaryWriter writer) {
    final int baseTypeNum = type & Fit.baseTypeNumMask;
    final val = value ?? Fit.baseType[baseTypeNum].invalidValue;

    switch (baseTypeNum) {
      case Fit.enum_:
      case Fit.uint8:
      case Fit.uint8z:
      case Fit.byte:
        writer.writeByte(val as int);
        break;
      case Fit.sint8:
        writer.writeSByte(val as int);
        break;
      case Fit.sint16:
        writer.writeInt16(val as int);
        break;
      case Fit.uint16:
      case Fit.uint16z:
        writer.writeUInt16(val as int);
        break;
      case Fit.sint32:
        writer.writeInt32(val as int);
        break;
      case Fit.uint32:
      case Fit.uint32z:
        writer.writeUInt32(val as int);
        break;
      case Fit.float32:
        writer.writeFloat32((val as dynamic).toDouble());
        break;
      case Fit.float64:
        writer.writeFloat64((val as dynamic).toDouble());
        break;
      case Fit.string:
        if (val is String) {
          writer.writeBytes(Uint8List.fromList(utf8.encode(val)));
          writer.writeByte(0); // Null terminator
        } else if (val is List<int>) {
          writer.writeBytes(Uint8List.fromList(val));
          if (val.isEmpty || val.last != 0) {
            // Caution: ifgetSize already counted the null terminator,
            // but it wasn't there, we might over-write.
            // But usually List<int> for strings in FIT includes the null terminator.
          }
        }
        break;
      case Fit.sint64:
        if (val is BigInt) {
          writer.writeSInt64(val.toInt());
        } else {
          writer.writeSInt64(val as int);
        }
        break;
      case Fit.uint64:
      case Fit.uint64z:
        if (val is BigInt) {
          writer.writeUInt64(val.toInt());
        } else {
          writer.writeUInt64(val as int);
        }
        break;
    }
  }

  Field? getField(int fieldNum) {
    for (var field in fields) {
      if (field.num == fieldNum) return field;
    }
    return null;
  }

  void setField(Field field) {
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].num == field.num) {
        fields[i] = field;
        return;
      }
    }
    fields.add(field);
  }

  void setDeveloperField(DeveloperField field) {
    final devKey = DeveloperDataKey(field.developerDataIndex, field.num);
    _developerFields[devKey] = field;
  }

  void insertField(int index, Field field) {
    fields.removeWhere((f) => f.num == field.num);
    if (index < 0 || index > fields.length) {
      fields.add(field);
    } else {
      fields.insert(index, field);
    }
  }

  void setFields(Mesg mesg) {
    if (mesg.num != num) return;
    for (var field in mesg.fields) {
      setField(Field.fromOther(field));
    }
  }

  int getNumFields() => fields.length;

  DeveloperField? _getDeveloperField(int fieldNum, int developerIndex) {
    final devKey = DeveloperDataKey(developerIndex, fieldNum);
    return _developerFields[devKey];
  }

  Iterable<FieldBase> getOverrideField(int fieldNum) {
    final List<FieldBase> localFields = [];
    final Field? nativeField = getField(fieldNum);
    if (nativeField != null) {
      localFields.add(nativeField);
    }

    for (var field in developerFields) {
      if (field.nativeOverride == fieldNum) {
        localFields.add(field);
      }
    }
    return localFields;
  }

  Field? getFieldByName(
    String fieldName, {
    bool checkMesgSupportForSubFields = true,
  }) {
    for (var field in fields) {
      if (field.name == fieldName) return field;
      for (var subfield in field.subfields) {
        if (subfield.name == fieldName &&
            (!checkMesgSupportForSubFields || subfield.canMesgSupport(this))) {
          return field;
        }
      }
    }
    return null;
  }

  int getActiveSubFieldIndex(int fieldNum) {
    final Field? testField = getField(fieldNum);
    if (testField == null) return Fit.subfieldIndexMainField;

    for (int i = 0; i < testField.subfields.length; i++) {
      if (testField.subfields[i].canMesgSupport(this)) {
        return i;
      }
    }
    return Fit.subfieldIndexMainField;
  }

  String getActiveSubFieldName(int fieldNum) {
    final Field? testField = getField(fieldNum);
    if (testField == null) return Fit.subfieldNameMainField;

    for (var subfield in testField.subfields) {
      if (subfield.canMesgSupport(this)) {
        return subfield.name;
      }
    }
    return Fit.subfieldNameMainField;
  }

  void removeField(Field field) {
    fields.remove(field);
  }

  int getNumFieldValues(Object fieldId, {Object? subfieldId}) {
    Field? field;
    if (fieldId is int) {
      field = getField(fieldId);
    } else if (fieldId is String) {
      field = getFieldByName(fieldId);
    }

    if (field == null) return 0;

    if (subfieldId == null || subfieldId == Fit.subfieldIndexActiveSubfield) {
      return field.getNumValues();
    }

    Subfield? subfield;
    if (subfieldId is int) {
      subfield = field.getSubfieldByIndex(subfieldId);
    } else if (subfieldId is String) {
      subfield = field.getSubfieldByName(subfieldId);
    }

    if (subfield == null || subfield.canMesgSupport(this)) {
      return field.getNumValues();
    } else {
      return 0;
    }
  }

  Object? getFieldValue(int fieldNum, {int index = 0, Object? subfieldInfo}) {
    final Field? field = getField(fieldNum);
    if (field == null) return null;

    int subfieldIndex;
    if (subfieldInfo == null ||
        subfieldInfo == Fit.subfieldIndexActiveSubfield) {
      subfieldIndex = getActiveSubFieldIndex(fieldNum);
    } else if (subfieldInfo is int) {
      subfieldIndex = subfieldInfo;
    } else if (subfieldInfo is String) {
      final Subfield? sub = field.getSubfieldByName(subfieldInfo);
      if (sub == null) return null;
      subfieldIndex = field.subfields.indexOf(sub);
    } else {
      return null;
    }

    final Subfield? subfield = field.getSubfieldByIndex(subfieldIndex);
    if (subfield == null || subfield.canMesgSupport(this)) {
      return field.getValue(
        index,
        subfieldInfo: subfieldIndex == Fit.subfieldIndexMainField
            ? null
            : subfieldIndex,
      );
    }
    return null;
  }

  Object? getFieldValueByName(String name, {int index = 0}) {
    final Field? field = getFieldByName(name, checkMesgSupportForSubFields: false);
    if (field == null) return null;

    final Subfield? subfield = field.getSubfieldByName(name);
    if (subfield == null || subfield.canMesgSupport(this)) {
      return field.getValue(index, subfieldName: name);
    }
    return null;
  }

  bool getIsFieldAccumulated(int num) {
    final Field? field = getField(num);
    return field?.isAccumulated ?? false;
  }

  void setFieldValue(
    int fieldNum,
    Object? value, {
    int index = 0,
    Object? subfieldId,
  }) {
    int subfieldIndex;
    if (subfieldId == null || subfieldId == Fit.subfieldIndexActiveSubfield) {
      subfieldIndex = getActiveSubFieldIndex(fieldNum);
    } else if (subfieldId is int) {
      subfieldIndex = subfieldId;
      final Subfield? subfield = getField(
        fieldNum,
      )?.getSubfieldByIndex(subfieldIndex);
      if (subfield != null && !subfield.canMesgSupport(this)) return;
    } else if (subfieldId is String) {
      final Field? testField = getField(fieldNum);
      final Subfield? subfield = testField?.getSubfieldByName(subfieldId);
      if (subfield != null && !subfield.canMesgSupport(this)) return;
      subfieldIndex =
          testField?.subfields.indexOf(subfield!) ?? Fit.subfieldIndexMainField;
    } else {
      return;
    }

    Field? field = getField(fieldNum);
    if (field == null) {
      final Mesg profileMesg = Profile.getMesg(num);
      final Field? profileField = profileMesg.getField(fieldNum);
      if (profileField != null) {
        field = Field.fromOther(profileField);
      } else {
        field = Field(
          'unknown',
          fieldNum,
          Fit.uint8,
          1.0,
          0.0,
          '',
          false,
          ProfileType.uint8,
        );
      }
      setField(field);
    }
    field.setValueAtIndex(
      index,
      value,
      subfieldInfo: subfieldIndex == Fit.subfieldIndexMainField
          ? null
          : subfieldIndex,
    );
  }

  void setFieldValueByName(String name, Object? value, {int index = 0}) {
    final Field? testField = getFieldByName(name);
    final Subfield? subfield = testField?.getSubfieldByName(name);
    if (subfield != null && !subfield.canMesgSupport(this)) return;

    Field? field = getFieldByName(name, checkMesgSupportForSubFields: false);
    if (field == null) {
      // Copy the profile's field into this message and write into the copy:
      // the profile's Field is shared by every message of this type. The
      // profile holds no values, so it can't select a subfield: resolve
      // subfield names without that check, as for fields already set above.
      final Field? profileField = Profile.getMesg(num)
          .getFieldByName(name, checkMesgSupportForSubFields: false);
      if (profileField == null) return;
      field = Field.fromOther(profileField);
      setField(field);
    }
    field.setValueAtIndex(index, value, subfieldName: name);
  }

  DateTime? timestampToDateTime(int? timestamp) {
    if (timestamp == null) return null;
    // FIT Epoch is Dec 31, 1989 00:00:00 UTC
    // 631065600000 ms from Unix Epoch
    return DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000 + 631065600000,
      isUtc: true,
    );
  }

  void removeExpandedFields() {
    fields.removeWhere((f) => f.isExpandedField);
  }

  void expandComponents(Accumulator accumulator) {
    // Traverse the field list
    // Use a length-based loop because fields might be added during expansion
    for (int i = 0; i < fields.length; ++i) {
      final Field field = fields[i];
      List<FieldComponent> componentList = [];

      final int activeSubfield = getActiveSubFieldIndex(field.num);
      if (activeSubfield == Fit.subfieldIndexMainField) {
        componentList = field.components;
      } else {
        componentList = field.subfields[activeSubfield].components;
      }

      int offset = 0;
      for (var fC in componentList) {
        if (fC.fieldNum != Fit.fieldNumInvalid) {
          Field? newField = Profile.getMesg(num).getField(fC.fieldNum);
          if (newField == null) continue;

          newField = Field.fromOther(newField);
          newField.isExpandedField = true;

          final Field? f = getField(newField.num);

          int? bitsValue = field.getBitsValue(offset, fC.bits, newField.type);
          if (bitsValue == null) break;

          if (fC.accumulate) {
            bitsValue = accumulator.accumulate(
              num,
              fC.fieldNum,
              bitsValue,
              fC.bits,
            );
          }

          if (newField.isNumeric()) {
            if (Fit.isNumericInvalid(bitsValue, newField.type)) {
              if (f != null) {
                f.setRawValue(f.getNumValues(), bitsValue);
              } else {
                newField.setRawValue(0, bitsValue);
              }
            } else {
              double fbitsValue = (bitsValue as dynamic).toDouble();
              fbitsValue = (fbitsValue / fC.scale) - fC.offset;

              if (f != null) {
                f.setValueAtIndex(f.getNumValues(), fbitsValue);
              } else {
                newField.setValue(fbitsValue);
              }
            }
          } else {
            Object nonNumericBitsValue;
            if ((newField.type & Fit.baseTypeNumMask) == Fit.string) {
              nonNumericBitsValue = Uint8List.fromList([bitsValue]);
            } else {
              nonNumericBitsValue = bitsValue;
            }

            if (f != null) {
              f.setValueAtIndex(f.getNumValues(), nonNumericBitsValue);
            } else {
              newField.setValue(nonNumericBitsValue);
            }
          }

          if (f == null) {
            fields.add(newField);
          }

          offset += fC.bits;
        }
      }
    }
  }
}
