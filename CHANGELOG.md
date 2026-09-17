
## 0.1.0

* Initial release
* Dart port of Garmin FIT SDK from C#
* Support for FIT Protocol v2.0
* Support for FIT Profile v21.188
* Core features:
  * Decode FIT files with full message parsing
  * Encode FIT files with message creation
  * Developer field support
  * Message broadcasting system
  * CRC validation
  * Protocol validation
* Includes all standard FIT message types
* Pure Dart implementation with no native dependencies

## 0.2.0

* **Enhanced 64-bit Integer Support**: Added proper handling for `sint64`, `uint64`, and `uint64z` data types in both reading and writing operations
* **Improved Field Writing Logic**: 
  * Optimized string field padding to avoid unnecessary iterations
  * Fixed field value writing to properly handle cases where field values are fewer than the defined size
  * Improved handling of null terminators in string fields
* **Message Definition Optimization**: Filter out empty fields (size = 0) when creating message definitions from messages to reduce file size
* **Enhanced Encoding API**: Added optional `MesgDefinition` parameter to `writeMesg()` method for more flexible message encoding
* **Code Quality Improvements**: Applied consistent code formatting across multiple files
* Tested and validated in production project

## 0.3.0

* **Run dart fix --apply**: auto fix the code style

## 0.4.0

* **Profile introspection (`FitProfileCatalog`)**: a read-only, synchronous catalog over the generated profile — enumerate messages and their fields (with units, scale/offset, `isArray`, subfields and components), and resolve enum types to their `value -> name` tables (e.g. `sport == 1` → `running`). Purely descriptive; it does not decode or encode.
  * New generated registries `lib/fit/profile/types/enum_type.dart` (value→name tables per `ProfileType`, with verbatim names) and `field_array.dart` (which fields are arrays), emitted by the profile generator so they stay in sync with `FIT_PROFILE_VERSION`.
  * `tool/generate_profile.dart` gains a `--regen-catalogs [profile.js]` mode to regenerate the derived catalogs without a full additive update.
  * Added the package's first unit tests (`test/profile_catalog_test.dart`) and an `example/catalog.dart`.

## 0.5.0

* **Profile documentation in `FitProfileCatalog`**: Garmin's `Profile.xlsx` (from [garmin/fit-sdk-tools](https://github.com/garmin/fit-sdk-tools)) now documents the catalog, for in-app help.
  * `doc` on `MessageInfo`, `FieldInfo`, `SubfieldInfo`, `EnumTypeInfo` and `EnumValueInfo`, plus `FitProfileCatalog.typeDoc()` for scalar types (e.g. `dateTime`) and `docsVersion`.
  * `MessageInfo.section` (e.g. `ACTIVITY FILE MESSAGES`), `FieldInfo.arrayLength` (fixed-size arrays such as `[3]`) and `EnumTypeInfo.baseType` (e.g. `uint32z`).
  * `EnumValueInfo.doc` now comes from `Profile.xlsx` too: 412 documented values instead of 384, none lost.
  * **Behaviour change:** `FieldInfo.isArray` follows the profile's `Array` column, so 40 string fields (e.g. `Sport.Name`) are no longer reported as arrays; true string arrays (e.g. `FieldDescription.FieldName`) still are.
  * `tool/generate_profile.dart` downloads the `Profile.xlsx` of the matching fit-sdk-tools release (or the closest earlier one), checks it against its Git LFS pointer, and emits `lib/fit/profile/types/profile_docs.dart`. Documentation failures only warn: they never block a profile update.
  * New dev dependencies for the generator only: `archive`, `xml`, `crypto`. The package itself still has no dependencies.
* **Subfields from the profile updater**: `tool/generate_profile.dart` now adds the subfields missing from existing fields (with their references and components), and the components of the fields it adds. It appends them after the existing subfields, which it leaves unchanged. At 21.214.0, `Session.TotalCycles` gains `TotalReps` (HIIT, strength training) and `TotalPushes` (wheelchair push walk/run). On those sessions, `getActiveSubFieldName` and `getFieldValueByName` resolve them, while the decoded field is still named `TotalCycles`. `SessionMesg` gains `getTotalReps()` and `getTotalPushes()`, and `FitProfileCatalog` lists both subfields.
  * **Behaviour change:** `Session.TotalCycles` subfields follow Garmin's order (`TotalReps`, `TotalStrides`, `TotalStrokes`, `TotalPushes`), because the first subfield whose references match wins. A running session with sub-sport strength training now resolves `TotalReps` instead of `TotalStrides`, as in Garmin's SDKs. `SessionTotalCyclesSubfield` follows that order: `TotalStrides` is now 1 (was 0) and `TotalStrokes` 2 (was 1).
* **`Mesg.setFieldValueByName` fix**: setting a field the message didn't have yet wrote the value into the profile's `Field`, which every message of that type shares. The message kept no value, and messages created afterwards (e.g. `SessionMesg()`) started with it. The value now goes into the message's own copy. A subfield name (e.g. `TotalReps`) also works now before its main field is set. As with `setFieldValue`, a subfield the message doesn't select (e.g. `TotalReps` on a running session) is now ignored: that check was there, but never rejected anything.
