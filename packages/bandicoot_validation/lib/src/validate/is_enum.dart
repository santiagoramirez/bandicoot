import 'package:bandicoot_validation/src/validation_rule.dart';

/// Check if a value is a valid enum value.
bool isEnum<T>(T value, T enumType) => value is T;

/// [ValidationRule] for [isEnum] validator.
ValidationRule IsEnum<T>(T enumType, {String? message}) => ValidationRule(
    message: message,
    constraints: [enumType],
    validate: (value, arguments) =>
        Future(() => isEnum(value, arguments.constraints[0])),
    defaultMessage: (arguments) =>
        '"$arguments.property" must be a valid enum of "$arguments.constraints[0]"');
