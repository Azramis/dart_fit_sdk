// Additive FIT-profile updater. Keeps every existing declaration in this repo
// byte-for-byte and only ADDS what a newer Garmin profile introduces: new enum
// values, new type classes, new message fields/getters, and new message classes
// (+ their createXMesg and switch case in profile.dart).
//
// Source: the `src/profile.js` of github.com/garmin/fit-javascript-sdk (itself
// generated from Garmin's Profile.xlsx). Profile data is © Garmin under the FIT
// Protocol License.
//
// Usage:
//   dart run tool/generate_profile.dart <path/to/profile.js>
//   dart format lib/fit/profile.dart lib/fit/profile

import 'dart:convert';
import 'dart:io';

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

String _pascal(String c) =>
    c.isEmpty ? c : c[0].toUpperCase() + c.substring(1);
String _typeClass(String t) => _classNameOverrides[t] ?? _pascal(t);
String _snake(String c) => c
    .replaceAllMapped(RegExp(r'([A-Z]+)([A-Z][a-z])'), (m) => '${m[1]}_${m[2]}')
    .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
    .toLowerCase();

String _ident(String name) {
  var n = name;
  if (RegExp(r'^[0-9]').hasMatch(n)) n = 'n$n';
  if (_reserved.contains(n)) n = '${n}_';
  return n;
}

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

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('Usage: dart run tool/generate_profile.dart <profile.js>');
    exit(64);
  }
  final profile = jsonDecode(_jsToJson(File(args.first).readAsStringSync()))
      as Map<String, dynamic>;
  final ver = profile['version'];
  _types = (profile['types'] as Map).cast<String, dynamic>();
  final messages = (profile['messages'] as Map).cast<String, dynamic>();

  _additiveTypes();
  _additiveMesgClasses(messages);
  _additiveProfileDart(messages);
  _generateMesgType(messages);

  stderr
    ..writeln('FIT profile v${ver['major']}.${ver['minor']}.${ver['patch']} '
        '— additive update.')
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
