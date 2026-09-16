import 'package:fit_sdk/fit_sdk.dart';

// Example demonstrating read-only introspection of the FIT profile via
// [FitProfileCatalog]: enumerate messages/fields, resolve enum values to their
// names, and read Garmin's documentation for them — without decoding any file.
void main() {
  final catalog = FitProfileCatalog();

  print('FIT Profile Catalog');
  print('=' * 60);
  print('${catalog.messages.length} messages, '
      '${catalog.enumTypes.length} named enum types '
      '(documentation from Profile.xlsx ${catalog.docsVersion}).\n');

  // 1. Inspect a message and its fields, with their documentation.
  final session = catalog.messageByName('session')!;
  print('Message "${session.name}" (num ${session.num}, '
      '${session.section}) — first 10 fields:');
  for (final field in session.fields.take(10)) {
    final units = field.units.isNotEmpty ? ' [${field.units}]' : '';
    final array = field.isArray ? '[${field.arrayLength ?? ''}]' : '';
    final enumType = catalog.enumType(field.type);
    final kind = enumType != null ? 'enum ${enumType.name}' : field.type.name;
    final doc = field.doc != null ? '\n      ${field.doc}' : '';
    print('  #${field.num} ${field.name}$array$units — $kind$doc');
  }

  // 2. Resolve enum values to names.
  print('\nSport enumeration (value -> name):');
  final sport = catalog.enumType(ProfileType.sport)!;
  for (final value in sport.values.take(6)) {
    final doc = value.doc != null ? '  // ${value.doc}' : '';
    print('  ${value.value} = ${value.name}$doc');
  }
  print('  ...');
  print('  sport.nameOf(1) = ${sport.nameOf(1)}'); // running
}
