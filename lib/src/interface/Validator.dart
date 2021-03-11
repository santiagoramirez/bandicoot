import 'package:bandicoot/bandicoot.dart';
import 'package:bandicoot/src/helpers/filtering.dart';

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
      List<String>? groups,
      List<ValidationRule>? validations,
      List<SanitizeRule>? sanitizers}) {
    this._validators.add(PropertyValidator(
        name: name,
        groups: groups,
        validations: validations,
        sanitizers: sanitizers));
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

    Iterable<PropertyValidator> filtered = this._validators.where((p) =>
        isInProperties(p.property, properties) && isInGroups(p.groups, groups));

    for (PropertyValidator propertyValidator in filtered) {
      List<String> propertyErrors =
          await this._getPropertyValidatorErrors(propertyValidator, values);

      if (propertyErrors.length > 0) {
        errors.addAll(propertyErrors);
      }
    }

    return errors;
  }

  /// Execute the validation rules on a [PropertyValidator] and return errors.
  Future<List<String>> _getPropertyValidatorErrors(
      PropertyValidator propertyValidator, Map values) async {
    String property = propertyValidator.property;
    dynamic value = values[property];
    List<String> errors = [];

    if (value == null) {
      if (propertyValidator.require) {
        return ['$property is a required field'];
      } else {
        return [];
      }
    }

    for (ValidationRule rule in propertyValidator.validations) {
      String? message =
          await this._getValidationRuleError(rule, property, values);

      if (message != null) {
        errors.add(message);
      }
    }

    return errors;
  }

  /// Execute [ValidationRule.validate] and return defined error message if validation does not pass.
  Future<String?> _getValidationRuleError(
      ValidationRule rule, String property, Map values) async {
    List<dynamic> constraints = rule.constraints;

    ValidationArguments arguments = ValidationArguments(
        property: property,
        constraints: constraints,
        value: values[property],
        values: values);

    bool pass = await rule.validate(values[property], arguments);

    if (pass == false && rule.message != null) {
      return rule.message;
    } else if (pass == false) {
      return rule.defaultMessage(arguments);
    } else {
      return null;
    }
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
