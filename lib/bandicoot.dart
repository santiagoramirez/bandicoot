import 'package:bandicoot/bandicoot.dart';
import 'package:bandicoot/validators.dart';

export 'src/PropertyValidator.dart';
export 'src/Sanitizer.dart';
export 'src/ValidationArguments.dart';
export 'src/Validator.dart';

class Bandicoot {
  List<PropertyValidator> _validators = [];

  Bandicoot([List<PropertyValidator>? validators]) {
    if (validators != null) {
      this._validators = validators;
    }
  }

  /// Adds a new property validator.
  void property(String property,
      {List<Validator>? validators, List<Sanitizer>? sanitizers}) {
    this._validators.add(PropertyValidator(property,
        validate: validators, sanitize: sanitizers));
  }

  /// Validates properties that have validators.
  ///
  /// Accepts a [map] property which is validated again property validations.
  /// Validations can be filtered to specific properties using [properties] named parameter.
  /// Additionally, validations can also be filtered by validation [groups].
  List<String> validate(Map map,
      {List<String>? properties,
      List<String>? groups,
      bool? whitelist: false}) {
    this._validators.forEach((validator) {
      // Validate logic will go here...
    });

    return [];
  }

  /// Sanitize properties that have sanitizers.
  ///
  /// Runs through property sanitizers and returns a [Map] of sanitized values.
  /// If a property does not have a sanitizer, the unsanitized value is returned.
  Map sanitize(Map map) {
    Map newMap = {};

    this._validators.forEach((validator) {
      // Sanitize logic will go here...
      String key = validator.property;
      newMap[key] = map[key];
    });

    return newMap;
  }
}

class BandicootMixin {
  late Bandicoot validator;

  List<String> validate({List<String>? properties}) =>
      this.validator.validate(this.toMap(), properties: properties);

  Map sanitize() {
    Map sanitizedMap = this.validator.sanitize(this.toMap());
    this.toClass(sanitizedMap);
    return sanitizedMap;
  }

  /// Used by [BandicootMixin.validate()] to validate class values.
  Map toMap() {
    throw UnimplementedError();
  }

  /// Used by [BandicootMixin.sanitize()] to write sanitized values to the class instance.
  void toClass(Map map) {
    throw UnimplementedError();
  }
}
