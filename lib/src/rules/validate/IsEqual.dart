import 'package:bandicoot/src/interface/ValidationRule.dart';

/// Check if two strings are equal.
bool isEqual(String string, String comparison) =>
    string.toString() == comparison.toString();

/// [ValidationRule] for [isEqual] validator.
ValidationRule<String> IsEqual(String comparison, {String? message}) =>
    ValidationRule(
        message: message,
        constraints: [comparison],
        validate: (value, arguments) =>
            Future(() => isEqual(value, arguments.constraints[0])),
        defaultMessage: (arguments) =>
            '"$arguments.property" must be equal to $arguments.constraints[0]');
