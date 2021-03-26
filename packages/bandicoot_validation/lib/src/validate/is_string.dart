import 'package:bandicoot_validation/src/validation_rule.dart';

/// Check if s given value is indeed a string.
bool isString(dynamic value) => value is String;

/// [ValidationRule] for [isString] validator.
ValidationRule IsString({String? message}) => ValidationRule(
    message: message,
    constraints: [],
    validate: (value, arguments) => Future(() => isString(value)),
    defaultMessage: (arguments) {
      String property = arguments.property;
      return '"$property" must be a valid string';
    });
