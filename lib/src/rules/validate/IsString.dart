import 'package:bandicoot/bandicoot.dart';

/// Check if s given value is indeed a string.
bool isString(dynamic value) => value is String;

/// [ValidationRule] for [isString] validator.
ValidationRule<dynamic> IsString({String? message}) => ValidationRule(
    message: message,
    constraints: [],
    validate: (value, arguments) => Future(() => isString(value)),
    defaultMessage: (arguments) =>
        '"$arguments.property" must be a valid string');
