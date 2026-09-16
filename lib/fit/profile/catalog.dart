import '../field_component.dart';
import '../mesg.dart';
import '../profile.dart';
import '../subfield.dart';
import 'mesgs/mesg_type.dart';
import 'types/enum_type.dart';
import 'types/field_array.dart';
import 'types/profile_docs.dart';

export 'types/enum_type.dart' show EnumValueInfo;

/// Read-only introspection over the generated FIT profile.
///
/// Purely descriptive: it lists the messages, fields and enumerations the
/// profile knows about — with their **verbatim** profile names — without
/// decoding anything or requiring [Mesg] instances. It is the counterpart to
/// the codec: where [Profile] builds messages to decode/encode bytes, this
/// catalog answers "what does the profile contain?".
///
/// It also carries the documentation Garmin publishes in Profile.xlsx (the
/// `doc` of messages, fields, subfields, types and enum values, and each
/// message's [MessageInfo.section]), for in-app help. That text is English,
/// terse, and absent for most elements, so treat every `doc` as optional.
///
/// All data is static and held in memory, so every accessor is synchronous.
/// The catalog is a lazily-built singleton — `FitProfileCatalog()` always
/// returns the same instance and does no work until first queried.
///
/// ```dart
/// final catalog = FitProfileCatalog();
///
/// // Messages and their fields:
/// final record = catalog.messageByName('record')!;
/// final hr = record.fieldByNum(3)!;      // FieldInfo(3, HeartRate), units "bpm"
///
/// // Enumerations, value -> name:
/// catalog.enumType(ProfileType.sport)!.nameOf(1); // "running"
///
/// // Documentation:
/// catalog.messageByName('session')!.fieldByName('TotalTimerTime')!.doc;
/// // "Timer Time (excludes pauses)"
/// ```
///
/// Names and documentation are returned exactly as the profile carries them
/// (fields in PascalCase, e.g. `HeartRate`). Normalisation (snake_case, etc.),
/// translation and curation are left to the caller.
class FitProfileCatalog {
  FitProfileCatalog._();

  static final FitProfileCatalog _instance = FitProfileCatalog._();

  /// Returns the shared, lazily-built catalog instance.
  factory FitProfileCatalog() => _instance;

  /// Every message known to the profile, in ascending message-number order.
  late final List<MessageInfo> messages = _buildMessages();

  late final Map<int, MessageInfo> _messagesByNum = {
    for (final m in messages) m.num: m,
  };

  late final Map<String, MessageInfo> _messagesByName = _buildMessageNames();

  /// Every named enumeration type in the profile (e.g. `sport`, `event`),
  /// sorted by name. Excludes base numeric types (`sint8`, ...) and scalar
  /// types such as `dateTime`.
  late final List<EnumTypeInfo> enumTypes = _buildEnumTypes();

  late final Map<ProfileType, EnumTypeInfo> _enumsByType = {
    for (final e in enumTypes) e.type: e,
  };

  /// The message with the given global [mesgNum] (e.g. `20` -> `Record`), or
  /// null when the profile has no such message.
  MessageInfo? messageByNum(int mesgNum) => _messagesByNum[mesgNum];

  /// The message matching [name], accepting either the PascalCase profile name
  /// (`Record`, as [MessageInfo.name] carries it) or the snake_case profile
  /// name (`record`). Returns null when unknown.
  MessageInfo? messageByName(String name) => _messagesByName[name];

  /// The enumeration description for [type], or null when [type] is a base
  /// numeric type (`sint8`, ...) or a non-enumeration scalar (`dateTime`, ...).
  EnumTypeInfo? enumType(ProfileType type) => _enumsByType[type];

  /// The Profile.xlsx comment on [type], or null when it has none. Covers every
  /// profile type, including scalars that have no [EnumTypeInfo] (e.g.
  /// `dateTime`: "seconds since UTC 00:00 Dec 31 1989").
  String? typeDoc(ProfileType type) => profileTypeDocs[type];

  /// Release of Garmin's FIT SDK tools whose Profile.xlsx the documentation
  /// comes from (e.g. `21.214.0`). It can predate the profile, since Garmin
  /// does not tag the tools for every profile release.
  String get docsVersion => profileDocsVersion;

  List<MessageInfo> _buildMessages() {
    final out = <MessageInfo>[];
    for (final t in MesgType.values) {
      final mesg = Profile.getMesg(t.num);
      out.add(MessageInfo._(
        t.num,
        mesg.name,
        profileMessageSections[t.num],
        profileMessageDocs[t.num],
        _buildFields(mesg),
      ));
    }
    out.sort((a, b) => a.num.compareTo(b.num));
    return List.unmodifiable(out);
  }

  Map<String, MessageInfo> _buildMessageNames() {
    final out = <String, MessageInfo>{};
    for (final m in messages) {
      out[m.name] = m; // PascalCase, e.g. "Record".
    }
    for (final t in MesgType.values) {
      final m = _messagesByNum[t.num];
      if (m != null) out.putIfAbsent(t.snakeName, () => m); // e.g. "record".
    }
    return out;
  }

  List<FieldInfo> _buildFields(Mesg mesg) {
    final arrays = profileArrayFields[mesg.num] ?? const <int>{};
    final lengths = profileArrayLengths[mesg.num] ?? const <int, int>{};
    final docs = profileFieldDocs[mesg.num] ?? const <int, String>{};
    final subfieldDocs =
        profileSubfieldDocs[mesg.num] ?? const <int, Map<String, String>>{};
    return List.unmodifiable(<FieldInfo>[
      for (final f in mesg.fields)
        FieldInfo._(
          f.num,
          f.name,
          f.units,
          f.scale,
          f.offset,
          f.profileType,
          arrays.contains(f.num),
          lengths[f.num],
          docs[f.num],
          _buildSubfields(
              f.subfields, subfieldDocs[f.num] ?? const <String, String>{}),
          _buildComponents(f.components),
        ),
    ]);
  }

  List<SubfieldInfo> _buildSubfields(
          List<Subfield> subfields, Map<String, String> docs) =>
      List.unmodifiable(<SubfieldInfo>[
        for (final s in subfields)
          SubfieldInfo._(
            s.name,
            s.type,
            s.scale,
            s.offset,
            s.units,
            List.unmodifiable(<SubfieldReference>[
              for (final m in s.maps)
                SubfieldReference._(m.refFieldNum, m.refFieldValue),
            ]),
            _buildComponents(s.components),
            docs[s.name],
          ),
      ]);

  List<ComponentInfo> _buildComponents(List<FieldComponent> components) =>
      List.unmodifiable(<ComponentInfo>[
        for (final c in components)
          ComponentInfo._(
              c.fieldNum, c.accumulate, c.bits, c.scale, c.offset, c.type),
      ]);

  List<EnumTypeInfo> _buildEnumTypes() {
    final out = <EnumTypeInfo>[];
    profileEnumTypeValues.forEach((type, values) {
      final docs = profileValueDocs[type] ?? const <int, String>{};
      out.add(EnumTypeInfo._(
        type,
        profileEnumTypeNames[type] ?? type.name,
        profileTypeBaseTypes[type],
        profileTypeDocs[type],
        List.unmodifiable(<EnumValueInfo>[
          for (final v in values) EnumValueInfo(v.name, v.value, docs[v.value]),
        ]),
      ));
    });
    out.sort((a, b) => a.name.compareTo(b.name));
    return List.unmodifiable(out);
  }
}

/// A message in the FIT profile: its global [num], its verbatim profile [name]
/// (PascalCase, e.g. `Record`) and its [fields].
class MessageInfo {
  const MessageInfo._(this.num, this.name, this.section, this.doc, this.fields);

  /// Global message number (e.g. 20 for `Record`).
  final int num;

  /// Profile name of the message, verbatim (PascalCase, e.g. `Record`).
  final String name;

  /// Section of Profile.xlsx the message is listed under, verbatim (e.g.
  /// `ACTIVITY FILE MESSAGES`). It tells where the profile documents the
  /// message, not every file type that may contain it. Null for the few
  /// messages listed before the first section (`file_id`, ...).
  final String? section;

  /// Profile.xlsx comment on the message (e.g. `Must be first message in
  /// file.`), or null when it has none.
  final String? doc;

  /// The message's fields, in profile order.
  final List<FieldInfo> fields;

  /// The field with the given [fieldNum], or null when the message has none.
  FieldInfo? fieldByNum(int fieldNum) {
    for (final f in fields) {
      if (f.num == fieldNum) return f;
    }
    return null;
  }

  /// The field with the given verbatim profile [fieldName], or null.
  FieldInfo? fieldByName(String fieldName) {
    for (final f in fields) {
      if (f.name == fieldName) return f;
    }
    return null;
  }

  @override
  String toString() => 'MessageInfo($num, $name, ${fields.length} fields)';
}

/// A field of a [MessageInfo].
///
/// When the field is an enumeration, [type] links to an [EnumTypeInfo] via
/// [FitProfileCatalog.enumType]; for plain numeric fields [type] is a base type
/// (`uint8`, ...) that has no enumeration.
class FieldInfo {
  const FieldInfo._(
      this.num,
      this.name,
      this.units,
      this.scale,
      this.offset,
      this.type,
      this.isArray,
      this.arrayLength,
      this.doc,
      this.subfields,
      this.components);

  /// Field number, unique within its message (e.g. 3 for heart rate).
  final int num;

  /// Profile name of the field, verbatim (PascalCase, e.g. `HeartRate`).
  final String name;

  /// Units the profile assigns (e.g. `bpm`); empty when the field is unitless.
  final String units;

  /// Scale applied to the raw value (1.0 when none).
  final double scale;

  /// Offset applied to the raw value (0.0 when none).
  final double offset;

  /// The field's profile type; pass it to [FitProfileCatalog.enumType] to get
  /// the value tables when it is an enumeration.
  final ProfileType type;

  /// Whether the field holds an array of values rather than a single one.
  /// Strings count as a single value unless the profile declares an array of
  /// strings (e.g. `FieldDescription.FieldName`).
  final bool isArray;

  /// Number of elements when the profile declares a fixed-size array (e.g. 3
  /// for `GpsMetadata.Velocity`); null for single values and variable-size
  /// arrays.
  final int? arrayLength;

  /// Profile.xlsx comment on the field (e.g. `Timer Time (excludes pauses)`),
  /// or null when it has none.
  final String? doc;

  /// Dynamic (reference) subfields the profile models for this field.
  final List<SubfieldInfo> subfields;

  /// Component-expansion targets the profile models for this field.
  final List<ComponentInfo> components;

  @override
  String toString() => 'FieldInfo($num, $name)';
}

/// A named enumeration type in the profile (e.g. `sport`), exposing its
/// [ProfileType], its verbatim [name] and its [values].
class EnumTypeInfo {
  EnumTypeInfo._(this.type, this.name, this.baseType, this.doc, this.values)
      : _byValue = {for (final v in values) v.value: v};

  /// The profile type this enumeration corresponds to (e.g.
  /// [ProfileType.sport]).
  final ProfileType type;

  /// Profile name of the type, verbatim (e.g. `sport`).
  final String name;

  /// FIT base type the values are stored as, verbatim (e.g. `enum`, `uint16`,
  /// `uint32z`), or null when the documentation does not cover the type.
  final String? baseType;

  /// Profile.xlsx comment on the type (e.g. for `sportBits0`: `Bit field
  /// corresponding to sport enum type (1 << sport).`), or null when it has
  /// none.
  final String? doc;

  /// Every named value of the enumeration, in profile order.
  final List<EnumValueInfo> values;

  final Map<int, EnumValueInfo> _byValue;

  /// The value name for [value] (e.g. 1 -> `running`), or null when [value] is
  /// not a named value of this enumeration.
  String? nameOf(int value) => _byValue[value]?.name;

  /// The [EnumValueInfo] for [value], or null when it is not a named value.
  EnumValueInfo? valueOf(int value) => _byValue[value];

  @override
  String toString() => 'EnumTypeInfo($name, ${values.length} values)';
}

/// A read-only view over a profile [Subfield]: a dynamic field whose meaning
/// depends on the value of another (reference) field.
class SubfieldInfo {
  const SubfieldInfo._(this.name, this.type, this.scale, this.offset,
      this.units, this.references, this.components, this.doc);

  /// Profile name of the subfield, verbatim.
  final String name;

  /// FIT base-type code of the subfield's values.
  final int type;

  /// Scale applied to the raw value (1.0 when none).
  final double scale;

  /// Offset applied to the raw value (0.0 when none).
  final double offset;

  /// Units the profile assigns (may be empty).
  final String units;

  /// Reference-field conditions under which this subfield applies.
  final List<SubfieldReference> references;

  /// Component-expansion targets modelled on the subfield.
  final List<ComponentInfo> components;

  /// Profile.xlsx comment on the subfield, or null when it has none.
  final String? doc;
}

/// One condition of a [SubfieldInfo]: the subfield applies when the field
/// numbered [fieldNum] holds [value].
class SubfieldReference {
  const SubfieldReference._(this.fieldNum, this.value);

  /// Number of the reference field to test.
  final int fieldNum;

  /// Value the reference field must hold for the subfield to apply.
  final Object value;
}

/// A read-only view over a profile [FieldComponent]: a slice of bits that
/// expands into another field during decoding.
class ComponentInfo {
  const ComponentInfo._(this.fieldNum, this.accumulate, this.bits, this.scale,
      this.offset, this.type);

  /// Target field number this component expands into.
  final int fieldNum;

  /// Whether the component's value accumulates across records.
  final bool accumulate;

  /// Number of bits the component occupies.
  final int bits;

  /// Scale applied to the expanded value (1.0 when none).
  final double scale;

  /// Offset applied to the expanded value (0.0 when none).
  final double offset;

  /// FIT base-type code of the target field.
  final int type;
}
