import 'package:bandicoot/bandicoot.dart';

/// Check if a property value is equal to another property value.
bool matchesProperty(String property1, String property2, Map map) =>
    map[property1].toString() == map[property2].toString();

/// [ValidationRule] for [matchesProperty] validator.
ValidationRule<String> MatchesProperty(String property, {String? message}) =>
    ValidationRule(
        message: message,
        constraints: [property],
        validate: (value, arguments) => Future(() => matchesProperty(
            arguments.property, arguments.constraints[0], arguments.values)),
        defaultMessage: (arguments) =>
            '"$arguments.property" must match "$arguments.constraints[0]"');
