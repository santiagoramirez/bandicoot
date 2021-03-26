import 'package:bandicoot_validation/src/property_validator.dart';
import 'package:bandicoot_validation/src/sanitize_rule.dart';
import 'package:bandicoot_validation/src/validation_arguments.dart';
import 'package:bandicoot_validation/src/validation_rule.dart';

/// Determine if [property] is in [properties] list.
bool _isInProperties(String property, List<String>? properties) {
  return properties == null ||
      (properties.length > 0 && properties.contains(property));
}

/// Determine if [propertyGroups] intersects with [groups].
bool _isInGroups(List<String>? propertyGroups, List<String>? groups) {
  bool hasGroups = groups != null && groups.length > 0;

  bool hasGroupsWithoutPropertyGroups = (hasGroups && propertyGroups == null);

  bool hasGroupsWithPropertyGroups = (hasGroups &&
      propertyGroups != null &&
      propertyGroups.length > 0 &&
      propertyGroups.any((g) => groups.contains(g)));

  return (!hasGroups ||
      hasGroupsWithoutPropertyGroups ||
      hasGroupsWithPropertyGroups);
}

class Validator<ClassType> {
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
        _isInProperties(p.property, properties) &&
        _isInGroups(p.groups, groups));

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
  Map sanitize(Map values) {
    Map sanitizedValues = {};

    for (PropertyValidator propertyValidator in this._validators) {
      sanitizedValues[propertyValidator.property] =
          this._sanitizeWithPropertyValidator(values, propertyValidator);
    }

    return sanitizedValues;
  }

  dynamic _sanitizeWithPropertyValidator(
      Map values, PropertyValidator propertyValidator) {
    dynamic newValue = values[propertyValidator.property];

    if (propertyValidator.sanitizers.length == 0) {
      return newValue;
    }

    for (SanitizeRule sanitizeRule in propertyValidator.sanitizers) {
      ValidationArguments arguments = ValidationArguments(
          property: propertyValidator.property,
          value: newValue,
          values: values,
          constraints: sanitizeRule.constraints);

      newValue = sanitizeRule.sanitize(newValue, arguments);
    }

    return newValue;
  }
}
