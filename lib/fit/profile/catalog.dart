import '../field.dart';
import '../mesg.dart';
import '../profile.dart';
import '../subfield.dart';
import '../field_component.dart';
import 'types/enum_registries.dart';
import 'mesgs/mesg_type.dart';

/// Read-only view over a [Subfield] for catalog introspection.
class SubfieldInfo {
  /// Profile name of the subfield (verbatim, e.g. `"genericName"`).
  final String name;

  /// Base type code (same encoding as [FieldInfo.type]).
  final int type;

  final double scale;
  final double offset;

  /// Physical unit string (may be empty).
  final String units;

  /// Reference field maps: each map entry says "this subfield applies when
  /// field [refFieldNum] has value [refFieldValue]".
  final List<({int refFieldNum, Object refFieldValue})> maps;

  /// Component-expansion targets defined on this subfield.
  final List<ComponentInfo> components;

  SubfieldInfo._({
    required this.name,
    required this.type,
    required this.scale,
    required this.offset,
    required this.units,
    required this.maps,
    required this.components,
  });

  static SubfieldInfo _fromSubfield(Subfield sf) {
    return SubfieldInfo._(
      name: sf.name,
      type: sf.type,
      scale: sf.scale,
      offset: sf.offset,
      units: sf.units,
      maps: sf.maps
          .map((m) => (refFieldNum: m.refFieldNum, refFieldValue: m.refFieldValue))
          .toList(growable: false),
      components: sf.components
          .map(ComponentInfo._fromFieldComponent)
          .toList(growable: false),
    );
  }
}

/// Read-only view over a [FieldComponent] for catalog introspection.
class ComponentInfo {
  /// Target field number that receives the expanded value.
  final int fieldNum;

  /// Whether this component value is accumulated.
  final bool accumulate;

  /// Number of bits in the component.
  final int bits;

  final double scale;
  final double offset;

  /// Base type code.
  final int type;

  ComponentInfo._({
    required this.fieldNum,
    required this.accumulate,
    required this.bits,
    required this.scale,
    required this.offset,
    required this.type,
  });

  static ComponentInfo _fromFieldComponent(FieldComponent fc) {
    return ComponentInfo._(
      fieldNum: fc.fieldNum,
      accumulate: fc.accumulate,
      bits: fc.bits,
      scale: fc.scale,
      offset: fc.offset,
      type: fc.type,
    );
  }
}

/// Read-only description of a single field within a FIT message.
class FieldInfo {
  /// Field number within its message (e.g. `3` for heart-rate in the record
  /// message).
  final int num;

  /// Profile name, verbatim as defined in the FIT profile (e.g. `"HeartRate"`).
  final String name;

  /// Physical unit string from the profile (e.g. `"bpm"`), or empty.
  final String units;

  final double scale;
  final double offset;

  /// The [ProfileType] for this field's values.  When [profileType] is a
  /// named enum type, [FitProfileCatalog.enumType] will return a non-null
  /// [EnumTypeInfo] for it.
  final ProfileType profileType;

  /// Dynamic subfields (alternative interpretations of this field).
  final List<SubfieldInfo> subfields;

  /// Component-expansion targets for packed / composite fields.
  final List<ComponentInfo> components;

  FieldInfo._({
    required this.num,
    required this.name,
    required this.units,
    required this.scale,
    required this.offset,
    required this.profileType,
    required this.subfields,
    required this.components,
  });

  static FieldInfo _fromField(Field f) {
    return FieldInfo._(
      num: f.num,
      name: f.name,
      units: f.units,
      scale: f.scale,
      offset: f.offset,
      profileType: f.profileType,
      subfields: f.subfields
          .map(SubfieldInfo._fromSubfield)
          .toList(growable: false),
      components: f.components
          .map(ComponentInfo._fromFieldComponent)
          .toList(growable: false),
    );
  }
}

/// Read-only description of a FIT message.
class MessageInfo {
  /// Global message number (a [MesgNum] constant, e.g. `20` for `record`).
  final int num;

  /// Profile name, verbatim (e.g. `"Record"`).
  final String name;

  /// All fields defined by the profile for this message.
  final List<FieldInfo> fields;

  MessageInfo._({
    required this.num,
    required this.name,
    required this.fields,
  });

  static MessageInfo _fromMesg(Mesg m) {
    return MessageInfo._(
      num: m.num,
      name: m.name,
      fields: m.fields.map(FieldInfo._fromField).toList(growable: false),
    );
  }
}

/// A single named value in a FIT enumeration.
class EnumValueInfo {
  /// Member name from the profile (verbatim camelCase, e.g. `"running"`).
  final String name;

  /// Integer value (e.g. `1`).
  final int value;

  const EnumValueInfo({required this.name, required this.value});
}

/// Read-only description of a named FIT enum type.
class EnumTypeInfo {
  /// The [ProfileType] this info describes.
  final ProfileType type;

  /// Profile type name (matches `ProfileType` member name, e.g. `"sport"`).
  final String name;

  /// All named values for this type.
  final List<EnumValueInfo> values;

  /// The value→name index (built lazily).
  late final Map<int, String> _index = {
    for (final v in values) v.value: v.name,
  };

  EnumTypeInfo._({
    required this.type,
    required this.name,
    required this.values,
  });

  /// Returns the member name for [value], or `null` if the value is unknown.
  String? nameOf(int value) => _index[value];
}

/// Read-only introspection over the generated FIT profile.
///
/// Purely descriptive: no decoding, no [Mesg] instances required.
/// All data is derived lazily from [Profile] and [kProfileTypeValues],
/// then cached for the lifetime of the catalog.
///
/// Use [instance] to obtain the shared singleton.
///
/// ```dart
/// final catalog = FitProfileCatalog.instance;
///
/// // Look up the "record" message (num 20)
/// final record = catalog.messageByNum(20)!;
/// print(record.name); // "Record"
///
/// // Enumerate sport values
/// final sport = catalog.enumType(ProfileType.sport)!;
/// print(sport.nameOf(1)); // "running"
/// ```
class FitProfileCatalog {
  FitProfileCatalog._();

  /// The shared, lazily-initialised singleton.
  static final FitProfileCatalog instance = FitProfileCatalog._();

  // ── lazy caches ──────────────────────────────────────────────────────────

  List<MessageInfo>? _messages;
  Map<String, MessageInfo>? _byName;
  Map<int, MessageInfo>? _byNum;
  Map<ProfileType, EnumTypeInfo>? _enumTypes;

  // ── public API ───────────────────────────────────────────────────────────

  /// All messages known to the profile, in [MesgType] declaration order.
  List<MessageInfo> get messages {
    _messages ??= _buildMessages();
    return _messages!;
  }

  /// Looks up a message by its profile name (case-insensitive).
  ///
  /// The profile name is the PascalCase Mesg.name value, e.g. `"Record"`.
  /// Returns `null` if no message with that name is known.
  MessageInfo? messageByName(String name) {
    _ensureMessageMaps();
    return _byName![name.toLowerCase()];
  }

  /// Looks up a message by its global message number.
  ///
  /// Returns `null` if no message with that number is known.
  MessageInfo? messageByNum(int mesgNum) {
    _ensureMessageMaps();
    return _byNum![mesgNum];
  }

  /// All named enum types in the profile.
  ///
  /// Base / scalar types (`sint8`, `dateTime`, …) are excluded.
  List<EnumTypeInfo> get enumTypes {
    _ensureEnumTypes();
    return List.unmodifiable(_enumTypes!.values);
  }

  /// Returns the [EnumTypeInfo] for [type], or `null` when [type] is a base
  /// numeric / scalar type that has no named values.
  EnumTypeInfo? enumType(ProfileType type) {
    _ensureEnumTypes();
    return _enumTypes![type];
  }

  // ── private helpers ──────────────────────────────────────────────────────

  List<MessageInfo> _buildMessages() {
    final result = <MessageInfo>[];
    for (final mt in MesgType.values) {
      final mesg = Profile.getMesg(mt.num);
      // getMesg returns an "unknown" Mesg for unknown nums; we only include
      // messages that the profile actually defines (name != "unknown").
      if (mesg.name == 'unknown') continue;
      result.add(MessageInfo._fromMesg(mesg));
    }
    return List.unmodifiable(result);
  }

  void _ensureMessageMaps() {
    if (_byName != null) return;
    final msgs = messages;
    _byName = {for (final m in msgs) m.name.toLowerCase(): m};
    _byNum = {for (final m in msgs) m.num: m};
  }

  void _ensureEnumTypes() {
    if (_enumTypes != null) return;
    final map = <ProfileType, EnumTypeInfo>{};
    for (final entry in kProfileTypeValues.entries) {
      final pt = entry.key;
      final valMap = entry.value;
      final values = valMap.entries
          .map((e) => EnumValueInfo(name: e.value, value: e.key))
          .toList(growable: false);
      map[pt] = EnumTypeInfo._(
        type: pt,
        name: pt.name,
        values: values,
      );
    }
    _enumTypes = Map.unmodifiable(map);
  }
}
