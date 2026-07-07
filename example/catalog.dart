import 'package:fit_sdk/fit_sdk.dart';

// Example demonstrating read-only introspection of the FIT profile via
// [FitProfileCatalog]: enumerate messages/fields and resolve enum values to
// their names — without decoding any file.
void main() {
  final catalog = FitProfileCatalog();

  print('FIT Profile Catalog');
  print('=' * 60);
  print('${catalog.messages.length} messages, '
      '${catalog.enumTypes.length} named enum types.\n');

  // 1. Inspect a message and its fields.
  final record = catalog.messageByName('record')!;
  print('Message "${record.name}" (num ${record.num}) — first 6 fields:');
  for (final field in record.fields.take(6)) {
    final units = field.units.isNotEmpty ? ' [${field.units}]' : '';
    final array = field.isArray ? '[]' : '';
    final enumType = catalog.enumType(field.type);
    final kind = enumType != null ? 'enum ${enumType.name}' : field.type.name;
    print('  #${field.num} ${field.name}$array$units — $kind');
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
