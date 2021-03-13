import 'package:bandicoot/src/api/validation_rule.dart';

/// Check if two strings are equal.
bool equals(String string, String comparison) =>
    string.toString() == comparison.toString();

/// [ValidationRule] for [equals] validator.
ValidationRule Equals(String comparison, {String? message}) => ValidationRule(
    message: message,
    constraints: [comparison],
    validate: (value, arguments) =>
        Future(() => equals(value, arguments.constraints[0])),
    defaultMessage: (arguments) =>
        '"$arguments.property" must be equal to $arguments.constraints[0]');
