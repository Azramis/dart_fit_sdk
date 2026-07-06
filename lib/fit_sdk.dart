/// FIT SDK for Dart
///
/// A Dart port of the Garmin FIT (Flexible and Interoperable Data Transfer) SDK.
/// This library allows you to encode and decode FIT files used by Garmin and
/// other fitness devices.
///
/// ## Features
///
/// - Decode FIT files from Garmin devices
/// - Encode new FIT files programmatically
/// - Full support for FIT Protocol v2.0
/// - Includes FIT Profile v21.188
/// - Developer field support
/// - Message broadcasting system
///
/// ## Usage
///
/// ### Decoding a FIT File
///
/// ```dart
/// import 'dart:io';
/// import 'package:fit_sdk/fit_sdk.dart';
///
/// void main() async {
///   final file = File('activity.fit');
///   final bytes = await file.readAsBytes();
///
///   final decoder = Decode();
///   decoder.onMesg = (Mesg mesg) {
///     print('Message: ${mesg.name}');
///   };
///
///   decoder.read(bytes);
/// }
/// ```
///
/// ### Encoding a FIT File
///
/// ```dart
/// import 'package:fit_sdk/fit_sdk.dart';
///
/// void main() {
///   final encoder = Encode();
///   encoder.open();
///
///   final fileIdMesg = FileIdMesg();
///   fileIdMesg.setType(File_.activity);
///
///   encoder.writeMesgDefinition(fileIdMesg.getDefinition());
///   encoder.writeMesg(fileIdMesg);
///
///   final bytes = encoder.close();
/// }
/// ```
library fit_sdk;

// Core FIT protocol
export 'fit/defines.dart';
export 'fit/fit_exception.dart';

// Encoding and Decoding
export 'fit/decode.dart';
export 'fit/encode.dart';
export 'fit/header.dart';

// Messages and Fields
export 'fit/mesg.dart';
export 'fit/mesg_definition.dart';
export 'fit/field.dart';
export 'fit/field_base.dart';
export 'fit/field_definition.dart';
export 'fit/field_component.dart';
export 'fit/subfield.dart';

// Developer Data
export 'fit/developer_field.dart';
export 'fit/developer_field_definition.dart';
export 'fit/developer_field_description.dart';
export 'fit/developer_data_key.dart';
export 'fit/developer_data_lookup.dart';

// Message Broadcasting
export 'fit/mesg_broadcaster.dart';
export 'fit/buffered_mesg_broadcaster.dart';
export 'fit/fit_listener.dart';
export 'fit/i_mesg_broadcast_plugin.dart';

// Profile (auto-generated message types)
export 'fit/profile.dart';
export 'fit/fit_messages.dart';
export 'fit/profile/types/mesg_num.dart';
export 'fit/profile/mesgs/mesgs.dart';
export 'fit/profile/mesgs/mesg_type.dart';
export 'fit/profile/types/types.dart';
export 'fit/profile/catalog.dart';

// Utilities
export 'fit/accumulator.dart';
export 'fit/crc.dart';
export 'fit/protocol_validator.dart';

// Binary I/O utilities
export 'utility/endian_binary_reader.dart';
export 'utility/endian_binary_writer.dart';
