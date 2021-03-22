import 'package:bandicoot_validation/src/api/validation_rule.dart';

/// Check if a string matches a given regex pattern.
bool matches(String string, String pattern) =>
    new RegExp(pattern).hasMatch(string);

/// [ValidationRule] for [matches] validator.
ValidationRule Matches(String pattern, {String? message}) => ValidationRule(
    message: message,
    constraints: [pattern],
    validate: (value, arguments) =>
        Future(() => matches(value, arguments.constraints[0])),
    defaultMessage: (arguments) => '"$arguments.property" must match regex');
