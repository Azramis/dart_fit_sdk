
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

* **Profile introspection (`FitProfileCatalog`)**: a read-only, synchronous catalog over the generated profile — enumerate messages and their fields (with units, scale/offset, subfields and components), and resolve enum types to their `value -> name` tables (e.g. `sport == 1` → `running`). Purely descriptive; it does not decode or encode.
  * New generated registry `lib/fit/profile/types/enum_type.dart` (value→name tables per `ProfileType`), emitted by the profile generator so it stays in sync with `FIT_PROFILE_VERSION`.
  * `tool/generate_profile.dart` gains a `--regen-catalogs` mode to regenerate the derived catalogs from the current sources.
  * Added the package's first unit tests (`test/profile_catalog_test.dart`) and an `example/catalog.dart`.
