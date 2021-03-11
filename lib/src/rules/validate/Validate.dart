import 'package:bandicoot/bandicoot.dart';

typedef bool _ValidateFunction<T>(T value);

/// [ValidationRule] for adding custom validations without the need to create a custom [ValidationRule].
ValidationRule<T> Validate<T>(_ValidateFunction validate, {String? message}) =>
    ValidationRule(
        message: message,
        constraints: [validate],
        validate: (value, arguments) =>
            Future(() => arguments.constraints[0](value)),
        defaultMessage: (arguments) =>
            '"$arguments.property" does not pass validation');
