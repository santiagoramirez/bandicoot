import 'package:bandicoot_validation/src/validation_rule.dart';

/// Check if a property value is equal to another property value.
bool matchesProperty(String property1, String property2, Map map) =>
    map[property1] == map[property2];

/// [ValidationRule] for [matchesProperty] validator.
ValidationRule MatchesProperty(String property, {String? message}) =>
    ValidationRule(
        message: message,
        constraints: [property],
        validate: (value, arguments) => Future(() => matchesProperty(
            arguments.property, arguments.constraints[0], arguments.values)),
        defaultMessage: (arguments) {
          String property1 = arguments.property;
          String property2 = arguments.constraints[0];
          return '"$property1" must match "$property2"';
        });
