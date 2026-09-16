// Additive FIT-profile updater. Keeps every existing declaration in this repo
// byte-for-byte and only ADDS what a newer Garmin profile introduces: new enum
// values, new type classes, new message fields/getters, and new message classes
// (+ their createXMesg and switch case in profile.dart).
//
// Sources: the `src/profile.js` of github.com/garmin/fit-javascript-sdk (itself
// generated from Garmin's Profile.xlsx), plus that Profile.xlsx from
// github.com/garmin/fit-sdk-tools for what profile.js leaves out (comments,
// message sections, array sizes). Profile data is © Garmin under the FIT
// Protocol License.
//
// Usage:
//   dart run tool/generate_profile.dart <path/to/profile.js>
//   dart run tool/generate_profile.dart --regen-catalogs [path/to/profile.js]
//   dart format lib/fit/profile.dart lib/fit/profile

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show BytesBuilder;

import 'package:archive/archive.dart' show ZipDecoder;
import 'package:crypto/crypto.dart' show sha256;
import 'package:xml/xml.dart';

const _baseTypeCode = <String, int>{
  'enum': 0, 'sint8': 1, 'uint8': 2, 'sint16': 131, 'uint16': 132,
  'sint32': 133, 'uint32': 134, 'string': 7, 'float32': 136, 'float64': 137,
  'uint8z': 10, 'uint16z': 139, 'uint32z': 140, 'byte': 13, 'sint64': 142,
  'uint64': 143, 'uint64z': 144,
};

const _reserved = {
  'abstract', 'as', 'assert', 'async', 'await', 'bool', 'break', 'case',
  'catch', 'class', 'const', 'continue', 'covariant', 'default', 'deferred',
  'do', 'dynamic', 'else', 'enum', 'export', 'extends', 'external', 'factory',
  'false', 'final', 'finally', 'for', 'get', 'if', 'implements', 'import', 'in',
  'interface', 'is', 'library', 'mixin', 'new', 'null', 'operator', 'part',
  'rethrow', 'return', 'set', 'static', 'super', 'switch', 'this', 'throw',
  'true', 'try', 'typedef', 'var', 'void', 'while', 'with', 'yield',
};

const _classNameOverrides = {'dateTime': 'FitDateTime'};

String _jsToJson(String s) {
  s = s.substring(s.indexOf('{'), s.lastIndexOf('}') + 1);
  s = s.replaceAll(RegExp(r'//[^\n]*'), '');
  s = s.replaceAllMapped(
    RegExp(r'([{,]\s*)([A-Za-z_0-9]+)\s*:'),
    (m) => '${m[1]}"${m[2]}":',
  );
  for (var i = 0; i < 6; i++) {
    s = s.replaceAllMapped(RegExp(r',(\s*[}\]])'), (m) => m[1]!);
  }
  return s;
}

/// The `major.minor.patch` version a parsed profile.js declares.
String _versionOf(Map<String, dynamic> profile) {
  final v = (profile['version'] as Map).cast<String, dynamic>();
  return '${v['major']}.${v['minor']}.${v['patch']}';
}

String _pascal(String c) =>
    c.isEmpty ? c : c[0].toUpperCase() + c.substring(1);
String _typeClass(String t) => _classNameOverrides[t] ?? _pascal(t);
String _snake(String c) => c
    .replaceAllMapped(RegExp(r'([A-Z]+)([A-Z][a-z])'), (m) => '${m[1]}_${m[2]}')
    .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
    .toLowerCase();

/// Inverse of [_snake] for the file/type names in this profile (which are all
/// lowerCamelCase): `sub_sport` -> `subSport`, `date_time` -> `dateTime`.
String _snakeToCamel(String s) {
  final parts = s.split('_');
  return parts.first + parts.skip(1).map(_pascal).join();
}

/// Renders [s] as a single-quoted Dart string literal, escaping as needed.
String _dartStr(String s) => "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll(r'$', r'\$').replaceAll('\r', '').replaceAll('\n', ' ')}'";

String _ident(String name) {
  var n = name;
  if (RegExp(r'^[0-9]').hasMatch(n)) n = 'n$n';
  if (_reserved.contains(n)) n = '${n}_';
  return n;
}

/// Reverses [_ident]'s reserved-word suffix so profile names round-trip
/// verbatim (e.g. `new_` -> `new`). No profile value name starts with a digit,
/// so the numeric-prefix branch never needs reversing.
String _unident(String n) =>
    n.endsWith('_') && _reserved.contains(n.substring(0, n.length - 1))
        ? n.substring(0, n.length - 1)
        : n;

int _baseType(dynamic n) => _baseTypeCode[n] ?? 0;
T _scalar<T>(dynamic v, T fb) =>
    v is List ? (v.isEmpty ? fb : v.first as T) : (v == null ? fb : v as T);
String _double(dynamic v) {
  final n = _scalar<num>(v, 1);
  return n == n.roundToDouble() ? '${n.toInt()}.0' : '$n';
}

String _intVal(String key) => '${key.startsWith('0x') ? int.parse(key.substring(2), radix: 16) : int.parse(key)}';

/// Inserts [text] just before the file's final `}`.
String _beforeLastBrace(String content, String text) {
  final i = content.lastIndexOf('}');
  return content.substring(0, i) + text + content.substring(i);
}

/// Indexes `class X` -> file path across a directory of generated Dart.
Map<String, File> _classIndex(Directory dir) {
  final out = <String, File>{};
  for (final f in dir.listSync().whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    for (final m in RegExp(r'^class (\w+)', multiLine: true)
        .allMatches(f.readAsStringSync())) {
      out[m.group(1)!] = f;
    }
  }
  return out;
}

late Map<String, dynamic> _types;
final _added = <String>[];
final _touched = <String>{};
final _format = <String>{}; // files needing `dart format` (not the type files,
// which only gain simple one-line constants and whose existing doc comments the
// formatter would otherwise reflow with spurious blank lines).

void _write(File f, String content, {bool format = true}) {
  f.writeAsStringSync(content);
  _touched.add(f.path);
  if (format) _format.add(f.path);
}

void _append(File f, String content, {bool format = true}) {
  f.writeAsStringSync(content, mode: FileMode.append);
  _touched.add(f.path);
  if (format) _format.add(f.path);
}

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln('Usage: dart run tool/generate_profile.dart <profile.js>\n'
        '       dart run tool/generate_profile.dart --regen-catalogs [profile.js]');
    exit(64);
  }

  // Regenerate the derived catalogs without an additive profile update. The
  // enum tables come from the in-repo type classes (no profile needed); pass a
  // profile.js to also refresh the parts that need Garmin's upstream sources
  // (field arrays, and the Profile.xlsx documentation of that release).
  if (args.first == '--regen-catalogs') {
    _generateEnumType();
    if (args.length > 1) {
      final profile = jsonDecode(_jsToJson(File(args[1]).readAsStringSync()))
          as Map<String, dynamic>;
      final docs = await _loadProfileDocs(_versionOf(profile));
      if (docs != null) {
        _generateProfileDocs(docs);
        _generateFieldArrays(
            (profile['messages'] as Map).cast<String, dynamic>(), docs);
      }
    }
    stdout.writeln(_format.join(' '));
    return;
  }

  final profile = jsonDecode(_jsToJson(File(args.first).readAsStringSync()))
      as Map<String, dynamic>;
  final version = _versionOf(profile);
  _types = (profile['types'] as Map).cast<String, dynamic>();
  final messages = (profile['messages'] as Map).cast<String, dynamic>();

  _additiveTypes();
  _additiveMesgClasses(messages);
  _additiveProfileDart(messages);
  _generateMesgType(messages);
  _generateEnumType();
  // Both registries depend on Profile.xlsx: without it, keep them as they are.
  final docs = await _loadProfileDocs(version);
  if (docs != null) {
    _generateProfileDocs(docs);
    _generateFieldArrays(messages, docs);
  }

  stderr
    ..writeln('FIT profile v$version — additive update.')
    ..writeln(_added.isEmpty ? 'Nothing new.' : _added.join('\n'));
  // Files needing formatting are printed to stdout (pipe to `xargs dart format`).
  stdout.writeln(_format.join(' '));
}

void _additiveTypes() {
  final dir = Directory('lib/fit/profile/types');
  final index = _classIndex(dir);
  final barrel = File('${dir.path}/types.dart');
  for (final entry in _types.entries) {
    final cls = _typeClass(entry.key);
    final values = (entry.value as Map).cast<String, dynamic>();
    final existing = index[cls];

    if (existing == null) {
      final buf = StringBuffer()..writeln('class $cls {');
      for (final v in values.entries) {
        buf.writeln('  static const int ${_ident(v.value as String)} = ${_intVal(v.key)};');
      }
      buf.writeln('}');
      final file = '${_snake(entry.key)}.dart';
      _write(File('${dir.path}/$file'), buf.toString(), format: false);
      if (barrel.existsSync()) {
        _append(barrel, "export '$file';\n", format: false);
      }
      _added.add('  + type $cls');
      continue;
    }

    final content = existing.readAsStringSync();
    final have = RegExp(r'=\s*(\d+);')
        .allMatches(content)
        .map((m) => int.parse(m.group(1)!))
        .toSet();
    final additions = StringBuffer();
    for (final v in values.entries) {
      final iv = int.parse(_intVal(v.key));
      if (have.contains(iv)) continue;
      additions.writeln('  static const int ${_ident(v.value as String)} = $iv;');
    }
    if (additions.isNotEmpty) {
      _write(existing, _beforeLastBrace(content, additions.toString()),
          format: false);
      _added.add('  ~ $cls (+${additions.toString().trim().split('\n').length} values)');
    }
  }
}

/// (Re)generates the message-type catalog: a `MesgType` enum listing every
/// message in the profile with its names and global MesgNum, for callers who
/// want to enumerate or filter the FIT message types at runtime. Fully derived
/// from [messages], so it is rewritten in whole on every run (messages are only
/// ever added upstream).
void _generateMesgType(Map<String, dynamic> messages) {
  final b = StringBuffer()
    ..writeln('// Auto-generated by tool/generate_profile.dart. Do not edit by hand.')
    ..writeln('//')
    ..writeln('// Every FIT message type available in this profile version.')
    ..writeln()
    ..writeln("import '../types/mesg_num.dart';")
    ..writeln()
    ..writeln('/// Every FIT message type available in this profile version.')
    ..writeln('///')
    ..writeln('/// Each value carries the message names and its global [MesgNum], so callers')
    ..writeln('/// can enumerate or filter the FIT message types at runtime.')
    ..writeln('enum MesgType {');
  for (final num in messages.keys.map(int.parse).toList()..sort()) {
    final name = (messages['$num'] as Map)['name'] as String;
    b.writeln("  ${_ident(name)}('${_pascal(name)}', '${_snake(name)}', MesgNum.${_ident(name)}),");
  }
  b
    ..writeln('  ;')
    ..writeln()
    ..writeln('  const MesgType(this.pascalName, this.snakeName, this.num);')
    ..writeln()
    ..writeln('  /// PascalCase name, matching `Mesg.name` on a decoded message.')
    ..writeln('  final String pascalName;')
    ..writeln()
    ..writeln('  /// snake_case name, matching the generated Dart file names.')
    ..writeln('  final String snakeName;')
    ..writeln()
    ..writeln('  /// Global message number (a [MesgNum] constant).')
    ..writeln('  final int num;')
    ..writeln()
    ..writeln('  static final Map<String, MesgType> _byPascalName = {')
    ..writeln('    for (final t in values) t.pascalName: t,')
    ..writeln('  };')
    ..writeln('  static final Map<String, MesgType> _bySnakeName = {')
    ..writeln('    for (final t in values) t.snakeName: t,')
    ..writeln('  };')
    ..writeln('  static final Map<int, MesgType> _byNum = {')
    ..writeln('    for (final t in values) t.num: t,')
    ..writeln('  };')
    ..writeln()
    ..writeln('  /// The message type whose [pascalName] equals [name], or null.')
    ..writeln('  static MesgType? byPascalName(String name) => _byPascalName[name];')
    ..writeln()
    ..writeln('  /// The message type whose [snakeName] equals [name], or null.')
    ..writeln('  static MesgType? bySnakeName(String name) => _bySnakeName[name];')
    ..writeln()
    ..writeln('  /// The message type whose [num] equals [num], or null.')
    ..writeln('  static MesgType? byNum(int num) => _byNum[num];')
    ..writeln('}')
    ..writeln();
  _write(File('lib/fit/profile/mesgs/mesg_type.dart'), b.toString());
}

/// Non-enumeration types that carry a generated class but must NOT be surfaced
/// as enums: timestamps whose only "values" are sentinels, not a named domain.
const _scalarTypes = {'dateTime', 'localDateTime'};

/// Files of lib/fit/profile/types/ that are not type classes: the barrel and
/// the generated registries.
const _registryFiles = {
  'types.dart',
  'enum_type.dart',
  'field_array.dart',
  'profile_docs.dart',
};

/// Extracts `(name, value)` rows from a generated type class, preserving
/// declaration order.
List<({String name, int value})> _parseTypeConstants(String content) => [
      for (final m
          in RegExp(r'^\s*static const int (\w+)\s*=\s*(\d+);', multiLine: true)
              .allMatches(content))
        (name: m.group(1)!, value: int.parse(m.group(2)!)),
    ];

/// The members of `enum ProfileType` in lib/fit/profile.dart: the only type
/// identifiers generated code may reference.
Set<String> _profileTypeMembers() => RegExp(r'\b(\w+)\b')
    .allMatches(RegExp(r'enum ProfileType \{([^}]*)\}')
        .firstMatch(File('lib/fit/profile.dart').readAsStringSync())!
        .group(1)!)
    .map((m) => m.group(1)!)
    .toSet();

/// (Re)generates the enum-value catalog: for every *named* enumeration type in
/// the profile, a `value -> name` table keyed by [ProfileType]. This is the
/// piece that makes the profile's enums introspectable at runtime — see
/// `lib/fit/profile/catalog.dart`. Their documentation lives in the Profile.xlsx
/// registry instead (see [_generateProfileDocs]).
///
/// Fully derived from the already-generated type classes under
/// `lib/fit/profile/types/`, so it is rewritten in whole on every run and can
/// be refreshed on its own with `--regen-catalogs` (no upstream profile
/// needed). Only [ProfileType] members are referenced, so unused profile types
/// and base/scalar types are naturally absent.
void _generateEnumType() {
  final dir = Directory('lib/fit/profile/types');
  final known = _profileTypeMembers();

  final types = <({String ident, String name, String body})>[];
  for (final f in dir.listSync().whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    final base = f.path.split(Platform.pathSeparator).last;
    if (_registryFiles.contains(base)) continue;
    final camel = _snakeToCamel(base.substring(0, base.length - '.dart'.length));
    if (_scalarTypes.contains(camel)) continue;
    final ident = _ident(camel);
    if (!known.contains(ident)) continue;

    final rows = _parseTypeConstants(f.readAsStringSync());
    if (rows.isEmpty) continue;

    final body = StringBuffer();
    for (final r in rows) {
      // Emit the verbatim profile name, undoing _ident's reserved-word suffix.
      body.writeln('    EnumValueInfo(${_dartStr(_unident(r.name))}, ${r.value}),');
    }
    types.add((ident: ident, name: camel, body: body.toString()));
  }
  types.sort((a, b) => a.ident.compareTo(b.ident));

  final b = StringBuffer()
    ..writeln(
        '// Auto-generated by tool/generate_profile.dart. Do not edit by hand.')
    ..writeln('//')
    ..writeln('// value -> name tables for every named enumeration type in this '
        'profile version.')
    ..writeln()
    ..writeln("import '../../profile.dart';")
    ..writeln()
    ..writeln('/// A single named value of a FIT enumeration: its [name], the raw')
    ..writeln('/// integer [value], and the optional [doc] the profile carries.')
    ..writeln('class EnumValueInfo {')
    ..writeln('  const EnumValueInfo(this.name, this.value, [this.doc]);')
    ..writeln()
    ..writeln('  /// Profile name of the value, verbatim (e.g. "running").')
    ..writeln('  final String name;')
    ..writeln()
    ..writeln('  /// Raw integer the profile assigns to this value (e.g. 1).')
    ..writeln('  final int value;')
    ..writeln()
    ..writeln('  /// Profile.xlsx comment on the value, if any (the tables below carry')
    ..writeln('  /// none: `FitProfileCatalog` fills it in from the documentation).')
    ..writeln('  final String? doc;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// Profile name of every named enumeration type, keyed by '
        '[ProfileType].')
    ..writeln('const Map<ProfileType, String> profileEnumTypeNames = {');
  for (final t in types) {
    b.writeln('  ProfileType.${t.ident}: ${_dartStr(t.name)},');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// `value -> name` tables for every named enumeration type, keyed')
    ..writeln('/// by [ProfileType]. Base numeric types (sint8, ...) and scalar')
    ..writeln('/// types (dateTime, ...) are intentionally absent.')
    ..writeln(
        'const Map<ProfileType, List<EnumValueInfo>> profileEnumTypeValues = {');
  for (final t in types) {
    b
      ..writeln('  ProfileType.${t.ident}: [')
      ..write(t.body)
      ..writeln('  ],');
  }
  b.writeln('};');

  _write(File('lib/fit/profile/types/enum_type.dart'), b.toString());
}

/// (Re)generates the field-array registry: for each message, the fields whose
/// values are arrays, and the element count of fixed-size ones. The catalog
/// surfaces them as `FieldInfo.isArray` / `FieldInfo.arrayLength` (the Dart
/// port's [Field] carries neither). Rewritten in whole on every run.
///
/// Profile.xlsx's `Array` column ([docs]) is authoritative for the fields it
/// documents. A field it doesn't document yet (the workbook can predate the
/// profile) falls back on profile.js's `array` flag, except for strings:
/// profile.js flags every string field as an array, while the profile documents
/// most of them as a single value. Only called when Profile.xlsx is available,
/// so a documentation outage leaves the previous registry untouched.
void _generateFieldArrays(Map<String, dynamic> messages, _ProfileDocs docs) {
  final arrays = StringBuffer();
  final lengths = StringBuffer();
  for (final num in messages.keys.map(int.parse).toList()..sort()) {
    final mesg = messages['$num'] as Map<String, dynamic>;
    final fields =
        ((mesg['fields'] as Map?) ?? const {}).cast<String, dynamic>();
    final documented = docs.fieldArrays[num] ?? const <int, String?>{};
    final arrayNums = <int>[];
    final sizes = <String>[];
    for (final fnum in fields.keys.map(int.parse).toList()..sort()) {
      final f = fields['$fnum'] as Map;
      final marker = documented[fnum]; // `[N]`, `[3]` or null (scalar)
      final isArray = documented.containsKey(fnum)
          ? marker != null
          : f['array'] == true && f['baseType'] != 'string';
      if (isArray) arrayNums.add(fnum);
      final size = RegExp(r'^\[(\d+)\]$').firstMatch(marker ?? '')?.group(1);
      if (size != null) sizes.add('$fnum: $size');
    }
    if (arrayNums.isNotEmpty) arrays.writeln('  $num: {${arrayNums.join(', ')}},');
    if (sizes.isNotEmpty) lengths.writeln('  $num: {${sizes.join(', ')}},');
  }

  final b = StringBuffer()
    ..writeln(
        '// Auto-generated by tool/generate_profile.dart. Do not edit by hand.')
    ..writeln('//')
    ..writeln(
        '// Which fields carry arrays, and how many elements the fixed-size '
        'ones hold.')
    ..writeln()
    ..writeln(
        '/// Field numbers whose values are arrays, keyed by global message')
    ..writeln(
        '/// number. A field absent from a message (or a message absent from')
    ..writeln(
        '/// the map) holds a single value. Consumed by `FitProfileCatalog`.')
    ..writeln('const Map<int, Set<int>> profileArrayFields = {')
    ..write(arrays)
    ..writeln('};')
    ..writeln()
    ..writeln(
        '/// Element count of the fields the profile declares as fixed-size')
    ..writeln('/// arrays (e.g. `[3]`), by message number then field number.')
    ..writeln('/// Variable-size arrays (`[N]`) and single values are absent.')
    ..writeln('const Map<int, Map<int, int>> profileArrayLengths = {')
    ..write(lengths)
    ..writeln('};');

  _write(File('lib/fit/profile/types/field_array.dart'), b.toString());
}

// ---------------------------------------------------------------------------
// Profile.xlsx documentation (github.com/garmin/fit-sdk-tools)
// ---------------------------------------------------------------------------

const _toolsRepo = 'garmin/fit-sdk-tools';

/// What Profile.xlsx adds on top of profile.js, keyed the way the catalog looks
/// things up: messages and fields by number, types by their profile.js
/// (camelCase) name, subfields by their Dart (PascalCase) name, enum values by
/// number then Profile.xlsx name. Messages, fields and enum values are joined by
/// number, because names don't all round-trip between the two sources
/// (`speed_1s` vs `speed1s`, `OHR` vs `ohr`); an enum value keeps its name only
/// to tell apart names sharing a number (`weather_report`: `forecast` and
/// `hourly_forecast` are both 1).
class _ProfileDocs {
  _ProfileDocs(this.version);

  /// fit-sdk-tools release the workbook was taken from.
  final String version;

  final messageSections = <int, String>{};
  final messageDocs = <int, String>{};
  final fieldDocs = <int, Map<int, String>>{};

  /// `Array` cell (`[N]`, `[3]`) of every documented field; null when scalar.
  final fieldArrays = <int, Map<int, String?>>{};

  final subfieldDocs = <int, Map<int, Map<String, String>>>{};
  final typeBaseTypes = <String, String>{};
  final typeDocs = <String, String>{};
  final valueDocs = <String, Map<int, Map<String, String>>>{};
}

void _warnDocs(String message) =>
    stderr.writeln('⚠ Profile.xlsx documentation: $message');

/// Upper bound for each download, so a stalled connection can't hang an update.
const _httpTimeout = Duration(seconds: 60);

/// The Profile.xlsx documentation for profile [version], or null when it can't
/// be obtained. Failures are reported and leave the previously generated
/// registries that depend on it (documentation and field arrays) in place:
/// documentation must never block a profile update.
Future<_ProfileDocs?> _loadProfileDocs(String version) async {
  try {
    final xlsx = await _fetchProfileXlsx(version);
    if (xlsx == null) return null;
    final docs = _parseProfileXlsx(xlsx.tag, xlsx.bytes);
    stderr.writeln('Documentation: Profile.xlsx from $_toolsRepo ${xlsx.tag}.');
    return docs;
  } catch (e) {
    // Deliberately broad (network, timeout, LFS mismatch, unexpected workbook
    // or API shape): whatever goes wrong, the profile update must go through.
    _warnDocs('$e — documentation and field arrays left unchanged.');
    return null;
  }
}

/// Downloads the Profile.xlsx of the fit-sdk-tools release matching [version],
/// or of the latest release before it: Garmin doesn't tag fit-sdk-tools for
/// every profile release. The workbook is stored with Git LFS, so the raw file
/// is a pointer whose size and SHA-256 the actual download must match.
Future<({String tag, List<int> bytes})?> _fetchProfileXlsx(
    String version) async {
  final client = HttpClient()..connectionTimeout = _httpTimeout;
  try {
    var tag = version;
    var raw = await _httpGet(client, _rawXlsxUrl(tag));
    if (raw == null) {
      final older = await _latestToolsTagUpTo(client, version);
      if (older == null) {
        _warnDocs('no $_toolsRepo release up to $version — documentation and '
            'field arrays left unchanged.');
        return null;
      }
      _warnDocs('$_toolsRepo has no $version release, using $older.');
      tag = older;
      raw = await _httpGet(client, _rawXlsxUrl(tag));
      if (raw == null) {
        throw HttpException('not found', uri: Uri.parse(_rawXlsxUrl(tag)));
      }
    }

    final pointer = raw.length > 512
        ? null
        : RegExp(r'oid sha256:([0-9a-f]{64})\s+size (\d+)')
            .firstMatch(utf8.decode(raw, allowMalformed: true));
    if (pointer == null) return (tag: tag, bytes: raw); // not stored with LFS

    final url =
        'https://media.githubusercontent.com/media/$_toolsRepo/$tag/Profile.xlsx';
    final bytes = await _httpGet(client, url);
    if (bytes == null ||
        bytes.length != int.parse(pointer[2]!) ||
        '${sha256.convert(bytes)}' != pointer[1]) {
      throw FormatException('does not match its Git LFS pointer', url);
    }
    return (tag: tag, bytes: bytes);
  } finally {
    client.close(force: true);
  }
}

String _rawXlsxUrl(String tag) =>
    'https://raw.githubusercontent.com/$_toolsRepo/$tag/Profile.xlsx';

/// The newest fit-sdk-tools release tag that is not newer than [version]. Reads
/// every page of the tags API (100 per page, capped at 20 pages).
Future<String?> _latestToolsTagUpTo(HttpClient client, String version) async {
  const perPage = 100;
  final tags = <String>[];
  for (var page = 1; page <= 20; page++) {
    final url = 'https://api.github.com/repos/$_toolsRepo/tags'
        '?per_page=$perPage&page=$page';
    final body = await _httpGet(client, url);
    if (body == null) throw HttpException('not found', uri: Uri.parse(url));
    final names = (jsonDecode(utf8.decode(body)) as List)
        .map((t) => (t as Map)['name'])
        .whereType<String>()
        .toList();
    tags.addAll(names);
    if (names.length < perPage) break;
  }
  final candidates = tags
      .where((t) =>
          RegExp(r'^\d+\.\d+\.\d+$').hasMatch(t) &&
          _compareVersions(t, version) <= 0)
      .toList()
    ..sort(_compareVersions);
  return candidates.isEmpty ? null : candidates.last;
}

/// Compares dotted numeric versions (`21.205.0` < `21.212.0`).
int _compareVersions(String a, String b) {
  final x = a.split('.').map(int.parse).toList();
  final y = b.split('.').map(int.parse).toList();
  for (var i = 0; i < x.length && i < y.length; i++) {
    if (x[i] != y[i]) return x[i].compareTo(y[i]);
  }
  return x.length.compareTo(y.length);
}

/// GETs [url]: its body, or null on 404. Throws [HttpException] otherwise, and
/// a `TimeoutException` when the whole exchange (connection, response and body)
/// exceeds [_httpTimeout].
Future<List<int>?> _httpGet(HttpClient client, String url) {
  Future<List<int>?> exchange() async {
    final response = await (await client.getUrl(Uri.parse(url))).close();
    if (response.statusCode != HttpStatus.ok) {
      await response.drain<void>();
      if (response.statusCode == HttpStatus.notFound) return null;
      throw HttpException('HTTP ${response.statusCode}', uri: Uri.parse(url));
    }
    final body = BytesBuilder(copy: false);
    await response.forEach(body.add);
    return body.takeBytes();
  }

  return exchange().timeout(_httpTimeout);
}

/// Parses Garmin's Profile.xlsx (sheets `Types` and `Messages`). Columns are
/// located by their header, not their position.
_ProfileDocs _parseProfileXlsx(String tag, List<int> bytes) {
  final sheets = _readXlsx(bytes);
  final docs = _ProfileDocs(tag);

  // Types: a type row names a type; the value rows below it list its values.
  final types = _sheet(sheets, 'Types');
  final t = _Columns(types.first,
      ['Type Name', 'Base Type', 'Value Name', 'Value', 'Comment']);
  final mesgNums = <String, int>{};
  String? type;
  for (final row in types.skip(1)) {
    final comment = t.of(row, 'Comment');
    final typeName = t.of(row, 'Type Name');
    final valueName = t.of(row, 'Value Name');
    final value = t.of(row, 'Value');
    if (typeName != null) {
      type = _snakeToCamel(typeName);
      final base = t.of(row, 'Base Type');
      if (base != null) docs.typeBaseTypes[type] = base;
      if (comment != null) docs.typeDocs[type] = comment;
    } else if (type != null && valueName != null && value != null) {
      final v = _parseProfileInt(value);
      if (comment != null) {
        ((docs.valueDocs[type] ??= {})[v] ??= {})[valueName] = comment;
      }
      if (type == 'mesgNum') mesgNums[valueName] = v;
    }
  }

  // Messages: a lone cell opens a section (e.g. `ACTIVITY FILE MESSAGES`), a
  // message row names a message, then come its field rows (with a Field Def #),
  // each followed by its subfield rows (with a Ref Field Name).
  final messages = _sheet(sheets, 'Messages');
  final m = _Columns(messages.first, [
    'Message Name',
    'Field Def #',
    'Field Name',
    'Array',
    'Ref Field Name',
    'Comment',
  ]);
  String? section;
  int? mesg, field;
  for (final row in messages.skip(1)) {
    final comment = m.of(row, 'Comment');
    final mesgName = m.of(row, 'Message Name');
    final fieldDef = m.of(row, 'Field Def #');
    final fieldName = m.of(row, 'Field Name');
    if (mesgName == null && fieldDef == null && fieldName == null) {
      if (row.length == 1) section = row.values.single;
    } else if (mesgName != null) {
      field = null;
      mesg = mesgNums[mesgName];
      if (mesg == null) {
        _warnDocs('message "$mesgName" is not a mesg_num value — skipped.');
        continue;
      }
      if (section != null) docs.messageSections[mesg] = section;
      if (comment != null) docs.messageDocs[mesg] = comment;
    } else if (mesg == null) {
      continue;
    } else if (fieldDef != null) {
      field = _parseProfileInt(fieldDef);
      (docs.fieldArrays[mesg] ??= {})[field] = m.of(row, 'Array');
      if (comment != null) (docs.fieldDocs[mesg] ??= {})[field] = comment;
    } else if (field != null &&
        fieldName != null &&
        m.of(row, 'Ref Field Name') != null &&
        comment != null) {
      ((docs.subfieldDocs[mesg] ??= {})[field] ??= {})
          .putIfAbsent(_pascal(_snakeToCamel(fieldName)), () => comment);
    }
  }
  return docs;
}

/// Parses a profile integer cell, decimal (`20`, `20.0`) or hex (`0xFF00`).
int _parseProfileInt(String s) => s.toLowerCase().startsWith('0x')
    ? int.parse(s.substring(2), radix: 16)
    : num.parse(s).toInt();

List<Map<String, String>> _sheet(
    Map<String, List<Map<String, String>>> sheets, String name) {
  final rows = sheets[name];
  if (rows == null || rows.isEmpty) throw FormatException('no sheet', name);
  return rows;
}

/// Looks cells up by the header text of their column.
class _Columns {
  _Columns(Map<String, String> header, List<String> names)
      : _letters = {for (final e in header.entries) e.value: e.key} {
    final missing = names.where((name) => !_letters.containsKey(name));
    if (missing.isNotEmpty) {
      throw FormatException('missing columns: ${missing.join(', ')}');
    }
  }

  final Map<String, String> _letters;

  /// The text of [row] under the column headed [name], or null when empty.
  String? of(Map<String, String> row, String name) => row[_letters[name]];
}

/// Namespace of the `r:id` attribute linking a sheet to its part.
const _relationshipsNs =
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships';

/// Reads an .xlsx workbook: for each sheet name, its rows, each mapping a column
/// letter to the trimmed text of its non-empty cells.
///
/// Elements are matched by local name (`namespaceUri: '*'`): Garmin's workbook
/// uses prefixed tags (`<x:sheet>`, `<x:row>`), other writers don't.
Map<String, List<Map<String, String>>> _readXlsx(List<int> bytes) {
  final zip = ZipDecoder().decodeBytes(bytes);
  XmlDocument part(String path) {
    final data = zip.find(path)?.readBytes();
    if (data == null) throw FormatException('no workbook part', path);
    final text = utf8.decode(data);
    return XmlDocument.parse(
        text.startsWith('﻿') ? text.substring(1) : text); // BOM
  }

  final shared = [
    for (final si in part('xl/sharedStrings.xml')
        .findAllElements('si', namespaceUri: '*'))
      si
          .findAllElements('t', namespaceUri: '*')
          .where((t) => t.parentElement?.localName != 'rPh') // skip phonetics
          .map((t) => t.innerText)
          .join(),
  ];
  final targets = {
    for (final r in part('xl/_rels/workbook.xml.rels')
        .findAllElements('Relationship', namespaceUri: '*'))
      r.getAttribute('Id'): r.getAttribute('Target'),
  };

  final sheets = <String, List<Map<String, String>>>{};
  for (final sheet
      in part('xl/workbook.xml').findAllElements('sheet', namespaceUri: '*')) {
    final name = sheet.getAttribute('name');
    final target =
        targets[sheet.getAttribute('id', namespaceUri: _relationshipsNs)];
    if (name == null || target == null) continue;
    final path = target.startsWith('/') ? target.substring(1) : 'xl/$target';
    sheets[name] = [
      for (final row in part(path).findAllElements('row', namespaceUri: '*'))
        _rowCells(row, shared),
    ];
  }
  return sheets;
}

Map<String, String> _rowCells(XmlElement row, List<String> shared) {
  final cells = <String, String>{};
  for (final c in row.findElements('c', namespaceUri: '*')) {
    final column =
        RegExp('^[A-Z]+').firstMatch(c.getAttribute('r') ?? '')?.group(0);
    final text = _cellText(c, shared)?.trim();
    if (column != null && text != null && text.isNotEmpty) cells[column] = text;
  }
  return cells;
}

/// Text of an .xlsx cell: a shared string, an inline string or a literal value.
String? _cellText(XmlElement c, List<String> shared) {
  final value = c.getElement('v', namespaceUri: '*')?.innerText;
  switch (c.getAttribute('t')) {
    case 's':
      final i = int.tryParse(value ?? '');
      return i == null || i >= shared.length ? null : shared[i];
    case 'inlineStr':
      return c
          .findAllElements('t', namespaceUri: '*')
          .map((t) => t.innerText)
          .join();
    default:
      return value;
  }
}

/// (Re)generates the documentation registry from Profile.xlsx: comments on
/// messages, fields, subfields, types and enum values, the section each message
/// is listed under, and each type's base type. Types are keyed by
/// [ProfileType], so types the Dart profile doesn't reference are skipped.
void _generateProfileDocs(_ProfileDocs docs) {
  final known = _profileTypeMembers();
  Iterable<(String, V)> byType<V>(Map<String, V> map) {
    final entries = [
      for (final e in map.entries)
        if (known.contains(_ident(e.key))) (_ident(e.key), e.value),
    ]..sort((a, b) => a.$1.compareTo(b.$1));
    return entries;
  }

  List<int> sorted(Iterable<int> keys) => keys.toList()..sort();

  final b = StringBuffer()
    ..writeln(
        '// Auto-generated by tool/generate_profile.dart. Do not edit by hand.')
    ..writeln('//')
    ..writeln("// Documentation from Garmin's Profile.xlsx "
        '(github.com/$_toolsRepo, release')
    ..writeln('// ${docs.version}). Profile data is © Garmin under the FIT '
        'Protocol License.')
    ..writeln()
    ..writeln("import '../../profile.dart';")
    ..writeln()
    ..writeln(
        '/// Release of $_toolsRepo whose Profile.xlsx this documentation')
    ..writeln('/// comes from. It can predate the profile: Garmin does not tag')
    ..writeln('/// fit-sdk-tools for every profile release.')
    ..writeln('const String profileDocsVersion = ${_dartStr(docs.version)};')
    ..writeln()
    ..writeln('/// Section of Profile.xlsx each message is listed under (e.g.')
    ..writeln('/// `ACTIVITY FILE MESSAGES`), by global message number.')
    ..writeln('const Map<int, String> profileMessageSections = {');
  for (final k in sorted(docs.messageSections.keys)) {
    b.writeln('  $k: ${_dartStr(docs.messageSections[k]!)},');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln(
        '/// Comment on each documented message, by global message number.')
    ..writeln('const Map<int, String> profileMessageDocs = {');
  for (final k in sorted(docs.messageDocs.keys)) {
    b.writeln('  $k: ${_dartStr(docs.messageDocs[k]!)},');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln(
        '/// Comment on each documented field, by message number then field')
    ..writeln('/// number.')
    ..writeln('const Map<int, Map<int, String>> profileFieldDocs = {');
  for (final mesg in sorted(docs.fieldDocs.keys)) {
    final fields = docs.fieldDocs[mesg]!;
    b.writeln('  $mesg: {');
    for (final f in sorted(fields.keys)) {
      b.writeln('    $f: ${_dartStr(fields[f]!)},');
    }
    b.writeln('  },');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln(
        '/// Comment on each documented subfield, by message number, field')
    ..writeln('/// number, then subfield name.')
    ..writeln(
        'const Map<int, Map<int, Map<String, String>>> profileSubfieldDocs = {');
  for (final mesg in sorted(docs.subfieldDocs.keys)) {
    final fields = docs.subfieldDocs[mesg]!;
    b.writeln('  $mesg: {');
    for (final f in sorted(fields.keys)) {
      b.writeln('    $f: {');
      final subs = fields[f]!;
      for (final name in subs.keys.toList()..sort()) {
        b.writeln('      ${_dartStr(name)}: ${_dartStr(subs[name]!)},');
      }
      b.writeln('    },');
    }
    b.writeln('  },');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// FIT base type each profile type is stored as (e.g. `enum`,')
    ..writeln('/// `uint32z`), by [ProfileType].')
    ..writeln('const Map<ProfileType, String> profileTypeBaseTypes = {');
  for (final (id, base) in byType(docs.typeBaseTypes)) {
    b.writeln('  ProfileType.$id: ${_dartStr(base)},');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// Comment on each documented profile type, by [ProfileType].')
    ..writeln('const Map<ProfileType, String> profileTypeDocs = {');
  for (final (id, doc) in byType(docs.typeDocs)) {
    b.writeln('  ProfileType.$id: ${_dartStr(doc)},');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// Comment on each documented enum value, by [ProfileType], value,')
    ..writeln('/// then value name as Profile.xlsx spells it (e.g. `OHR`). The name')
    ..writeln('/// only tells apart names sharing a value (`forecast` and')
    ..writeln('/// `hourly_forecast`). Scalar types (dateTime, ...) have no value')
    ..writeln('/// table, so their sentinel values are left out.')
    ..writeln('const Map<ProfileType, Map<int, Map<String, String>>> '
        'profileValueDocs = {');
  final enumValueDocs = {
    for (final e in docs.valueDocs.entries)
      if (!_scalarTypes.contains(e.key)) e.key: e.value,
  };
  for (final (id, values) in byType(enumValueDocs)) {
    b.writeln('  ProfileType.$id: {');
    for (final v in sorted(values.keys)) {
      final names = values[v]!;
      b.writeln('    $v: {');
      for (final name in names.keys.toList()..sort()) {
        b.writeln('      ${_dartStr(name)}: ${_dartStr(names[name]!)},');
      }
      b.writeln('    },');
    }
    b.writeln('  },');
  }
  b.writeln('};');

  _write(File('lib/fit/profile/types/profile_docs.dart'), b.toString());
}

void _additiveMesgClasses(Map<String, dynamic> messages) {
  final dir = Directory('lib/fit/profile/mesgs');
  final index = _classIndex(dir);
  final barrel = File('${dir.path}/mesgs.dart');

  for (final num in messages.keys.map(int.parse).toList()..sort()) {
    final mesg = messages['$num'] as Map<String, dynamic>;
    final name = mesg['name'] as String;
    final cls = '${_pascal(name)}Mesg';
    final fields = ((mesg['fields'] as Map?) ?? const {}).cast<String, dynamic>();
    final existing = index[cls];

    if (existing == null) {
      _write(File('${dir.path}/${_snake(name)}_mesg.dart'),
          _mesgClassSource(name, fields));
      if (barrel.existsSync()) {
        _append(barrel, "export '${_snake(name)}_mesg.dart';\n");
      }
      _added.add('  + message $cls');
      continue;
    }

    var content = existing.readAsStringSync();
    final have = RegExp(r'field\w+\s*=\s*(\d+);')
        .allMatches(content)
        .map((m) => int.parse(m.group(1)!))
        .toSet();
    final consts = StringBuffer();
    final getters = StringBuffer();
    for (final fnum in fields.keys.map(int.parse)) {
      if (have.contains(fnum)) continue;
      final f = fields['$fnum'] as Map<String, dynamic>;
      consts.writeln('  static const int field${_pascal(f['name'] as String)} = $fnum;');
      getters.write(_getterSource(name, f, fnum));
    }
    if (consts.isNotEmpty) {
      content = content.replaceFirst(
        '  static const int fieldInvalid',
        '${consts.toString()}  static const int fieldInvalid',
      );
      content = _beforeLastBrace(content, getters.toString());
      _write(existing, content);
      _added.add('  ~ $cls (+${consts.toString().trim().split('\n').length} fields)');
    }
  }
}

/// Builds the full source of a brand-new mesg class.
String _mesgClassSource(String name, Map<String, dynamic> fields) {
  final cls = '${_pascal(name)}Mesg';
  final b = StringBuffer()
    ..writeln("import '../../defines.dart';")
    ..writeln("import '../../mesg.dart';")
    ..writeln("import '../../profile.dart';")
    ..writeln("import '../types/mesg_num.dart';")
    ..writeln("import '../types/types.dart';")
    ..writeln()
    ..writeln('class $cls extends Mesg {');
  for (final fnum in fields.keys.map(int.parse)) {
    final f = fields['$fnum'] as Map;
    b.writeln('  static const int field${_pascal(f['name'] as String)} = $fnum;');
  }
  b
    ..writeln('  static const int fieldInvalid = Fit.fieldNumInvalid;')
    ..writeln()
    ..writeln('  $cls() : super.from(Profile.getMesg(MesgNum.${_ident(name)}));')
    ..writeln('  $cls.fromMesg(super.mesg) : super.from();')
    ..writeln();
  for (final fnum in fields.keys.map(int.parse)) {
    b.write(_getterSource(name, fields['$fnum'] as Map<String, dynamic>, fnum));
  }
  b.writeln('}');
  return b.toString();
}

String _getterSource(String mesg, Map<String, dynamic> f, int fnum) {
  final b = StringBuffer();
  final g = _getter(f, fnum, 'Fit.subfieldIndexMainField');
  b
    ..writeln('  ${g.type}? get${_pascal(f['name'] as String)}() {')
    ..writeln('    ${g.body}')
    ..writeln('  }')
    ..writeln();
  return b.toString();
}

({String type, String body}) _getter(Map f, int fieldNum, String info) {
  final read =
      'final val = getFieldValue($fieldNum, index: 0, subfieldInfo: $info,);';
  final type = f['type'] as String?;
  final base = f['baseType'] as String?;
  final scale = _scalar<num>(f['scale'], 1);
  final offset = _scalar<num>(f['offset'], 0);
  // Upstream returns DateTime? for `dateTime` but int? for `localDateTime`.
  if (type == 'dateTime') {
    return (
      type: 'DateTime',
      body: '$read\nreturn val == null ? null : '
          'DateTime.fromMillisecondsSinceEpoch((val as int) * 1000 + 631065600000,);',
    );
  }
  if (base == 'string') return (type: 'String', body: '$read\nreturn val?.toString();');
  if (base == 'float32' || base == 'float64' || scale != 1 || offset != 0) {
    return (type: 'double', body: '$read\nreturn (val as num?)?.toDouble();');
  }
  return (type: 'int', body: '$read\nreturn val as int?;');
}

void _additiveProfileDart(Map<String, dynamic> messages) {
  final file = File('lib/fit/profile.dart');
  var content = file.readAsStringSync();

  // 1. New ProfileType enum entries for any referenced type not present.
  final enumNames = RegExp(r'enum ProfileType \{([^}]*)\}')
      .firstMatch(content)!
      .group(1)!;
  final present = RegExp(r'\b(\w+)\b').allMatches(enumNames).map((m) => m.group(1)!).toSet();
  final referenced = <String>{};
  void ref(Map<String, dynamic> fields) {
    for (final f in fields.values) {
      referenced.add(_ident((f as Map)['type'] as String));
    }
  }

  final switchCases = StringBuffer();
  final creators = StringBuffer();

  for (final num in messages.keys.map(int.parse).toList()..sort()) {
    final mesg = messages['$num'] as Map<String, dynamic>;
    final name = mesg['name'] as String;
    final fields = ((mesg['fields'] as Map?) ?? const {}).cast<String, dynamic>();
    ref(fields);

    if (content.contains('static Mesg create${_pascal(name)}Mesg()')) {
      // Existing message: append any new fields into its creator.
      final have = RegExp(
        'static Mesg create${_pascal(name)}Mesg\\(\\) \\{[\\s\\S]*?return newMesg;',
      ).firstMatch(content);
      if (have == null) continue;
      final block = have.group(0)!;
      // Field calls are dart-formatted multi-line, so match across whitespace.
      final existingNums = RegExp(r'Field\(\s*"[^"]*"\s*,\s*(\d+)\s*,')
          .allMatches(block)
          .map((m) => int.parse(m.group(1)!))
          .toSet();
      final adds = StringBuffer();
      for (final fnum in fields.keys.map(int.parse)) {
        if (existingNums.contains(fnum)) continue;
        adds.write('    newMesg.setField(${_fieldCtor(fields['$fnum'] as Map)},);\n');
      }
      if (adds.isNotEmpty) {
        content = content.replaceFirst(
          block,
          block.replaceFirst('return newMesg;', '${adds.toString()}    return newMesg;'),
        );
        _added.add('  ~ create${_pascal(name)}Mesg (+${adds.toString().trim().split('\n').length} fields)');
      }
      continue;
    }

    // New message: switch case + creator function.
    switchCases.writeln('      case MesgNum.${_ident(name)}:');
    switchCases.writeln('        newMesg = create${_pascal(name)}Mesg();');
    switchCases.writeln('        break;');
    creators.write(_creatorSource(name, fields));
  }

  // Apply ProfileType additions.
  final missing = referenced.difference(present).toList()..sort();
  if (missing.isNotEmpty) {
    // The enum's last entry already ends with a trailing comma; append after it.
    content = content.replaceFirstMapped(
      RegExp(r'(enum ProfileType \{[\s\S]*?)(\s*\})'),
      (m) => '${m[1]}\n  ${missing.join(',\n  ')},${m[2]}',
    );
    _added.add('  ~ ProfileType (+${missing.length})');
  }

  if (switchCases.isNotEmpty) {
    content = content.replaceFirst('      default:\n        break;',
        '$switchCases      default:\n        break;');
    content = _beforeLastBrace(content, creators.toString());
  }

  _write(file, content);
}

String _fieldCtor(Map f) =>
    'Field("${_pascal(f['name'] as String)}", ${f['num']}, ${_baseType(f['baseType'])}, '
    '${_double(f['scale'])}, ${_double(f['offset'])}, "${_scalar<String>(f['units'], '')}", '
    '${f['isAccumulated'] == true}, ProfileType.${_ident(f['type'] as String)})';

String _creatorSource(String name, Map<String, dynamic> fields) {
  final b = StringBuffer()
    ..writeln('  static Mesg create${_pascal(name)}Mesg() {')
    ..writeln('    final Mesg newMesg = Mesg("${_pascal(name)}", MesgNum.${_ident(name)});');
  for (final fnum in fields.keys.map(int.parse)) {
    b.writeln('    newMesg.setField(${_fieldCtor(fields['$fnum'] as Map)},);');
  }
  b
    ..writeln('    return newMesg;')
    ..writeln('  }')
    ..writeln();
  return b.toString();
}
