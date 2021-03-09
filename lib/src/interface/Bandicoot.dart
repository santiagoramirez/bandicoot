import 'package:bandicoot/bandicoot.dart';

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
