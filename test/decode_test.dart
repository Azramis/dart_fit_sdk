import 'dart:typed_data';

import 'package:fit_sdk/fit_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('compressed timestamp headers', () {
    // Its low five bits are 28, so time offsets wrap within a few seconds.
    const reference = 1000000028;

    test('give each message the Timestamp its time offset encodes', () {
      final fit = _FitFile()
        // Records with a full Timestamp set the reference...
        ..define(0, MesgNum.record, [
          (RecordMesg.fieldTimestamp, Fit.uint32),
          (RecordMesg.fieldHeartRate, Fit.uint8),
        ])
        ..mesg(0, [..._uint32(reference), 100])
        // ...that compressed headers, on a definition without one, advance.
        ..define(1, MesgNum.record, [(RecordMesg.fieldHeartRate, Fit.uint8)])
        ..compressed(1, 30, [101]) // 28 -> 30: +2 s
        ..compressed(1, 1, [102]) // 30 -> 1 wraps: +3 s
        ..compressed(1, 1, [103]) // same offset: +0 s
        // A new full Timestamp, whose low five bits are 0, resets it.
        ..mesg(0, [..._uint32(reference + 100), 104])
        ..compressed(1, 4, [105]); // 0 -> 4: +4 s

      final records = _decode(fit.bytes());
      expect(records.map((r) => r.getFieldValue(RecordMesg.fieldHeartRate)),
          [100, 101, 102, 103, 104, 105]);
      expect(records.map((r) => r.getField(RecordMesg.fieldTimestamp)?.name),
          everyElement('Timestamp'));
      expect(records.map((r) => r.getFieldValue(RecordMesg.fieldTimestamp)), [
        reference,
        reference + 2,
        reference + 5,
        reference + 5,
        reference + 100,
        reference + 104,
      ]);
    });

    test('count from any field named Timestamp, as the C# SDK does', () {
      // Set carries its Timestamp in field 254, not 253.
      final fit = _FitFile()
        ..define(0, MesgNum.set_, [(SetMesg.fieldTimestamp, Fit.uint32)])
        ..mesg(0, _uint32(reference))
        ..define(1, MesgNum.record, [(RecordMesg.fieldHeartRate, Fit.uint8)])
        ..compressed(1, 30, [101]);

      final record = _decode(fit.bytes()).last;
      expect(record.getFieldValue(RecordMesg.fieldTimestamp), reference + 2);
    });
  });
}

List<Mesg> _decode(Uint8List fit) {
  final mesgs = <Mesg>[];
  (Decode()..onMesg = mesgs.add).read(fit);
  return mesgs;
}

List<int> _uint32(int value) =>
    [for (var shift = 0; shift < 32; shift += 8) value >> shift & 0xff];

/// A FIT file written byte by byte, since [Encode] only writes normal headers.
class _FitFile {
  final _records = EndianBinaryWriter();

  /// Defines local message [local] as the little-endian global message
  /// [global], with its fields as (field number, base type) pairs.
  void define(int local, int global, List<(int, int)> fields) {
    _records
      ..writeByte(Fit.mesgDefinitionMask | local)
      ..writeByte(Fit.mesgDefinitionReserved)
      ..writeByte(Fit.littleEndian)
      ..writeUInt16(global)
      ..writeByte(fields.length);
    for (final (num, type) in fields) {
      _records
        ..writeByte(num)
        ..writeByte(Fit.baseType[type].size)
        ..writeByte(Fit.baseType[type].baseTypeField);
    }
  }

  /// A data message with a normal header.
  void mesg(int local, List<int> fieldBytes) => _records
    ..writeByte(local)
    ..writeBytes(Uint8List.fromList(fieldBytes));

  /// A data message with a compressed timestamp header.
  void compressed(int local, int timeOffset, List<int> fieldBytes) => _records
    ..writeByte(Fit.compressedHeaderMask | (local << 5) | timeOffset)
    ..writeBytes(Uint8List.fromList(fieldBytes));

  Uint8List bytes() {
    final records = _records.toBytes();
    final header = Header()
      ..dataSize = records.length
      ..updateCrc();
    final file = EndianBinaryWriter();
    header.write(file);
    file.writeBytes(records);
    final withoutCrc = file.toBytes();
    file.writeUInt16(Crc.calc16(withoutCrc, withoutCrc.length));
    return file.toBytes();
  }
}
