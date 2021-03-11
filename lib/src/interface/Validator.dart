import 'package:bandicoot/bandicoot.dart';

class Validator {
  List<PropertyValidator> _validators = [];

  Validator([List<PropertyValidator>? validators]) {
    if (validators != null) {
      this._validators = validators;
    }
  }

  /// Adds a new property validator.
  void property(
      {required String name,
      List<ValidationRule>? validations,
      List<SanitizeRule>? sanitizers}) {
    this._validators.add(PropertyValidator(
        name: name, validations: validations, sanitizers: sanitizers));
  }

  /// Validates properties that have validators.
  ///
  /// Accepts a [map] property which is validated again property validations.
  /// Validations can be filtered to specific properties using [properties] named parameter.
  /// Additionally, validations can also be filtered by validation [groups].
  Future<List<String>> validate(Map values,
      {List<String>? properties,
      List<String>? groups,
      bool? whitelist: false}) async {
    List<String> errors = [];

    for (PropertyValidator validator in this._validators) {
      String property = validator.property;
      dynamic value = values[property];

      if (value == null) {
        errors.add('$property cannot be null');
        continue;
      }

      for (ValidationRule rule in validator.validations) {
        List<dynamic> constraints = rule.constraints;

        ValidationArguments arguments = ValidationArguments(
            property: property,
            constraints: constraints,
            value: value,
            values: values);

        bool pass = await rule.validate(value, arguments);

        if (pass == false) {
          errors.add(rule.defaultMessage(arguments));
        }
      }
    }

    return errors;
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
