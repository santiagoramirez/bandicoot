import 'package:bandicoot/src/api/validation_rule.dart';

typedef bool _ValidateFunction(dynamic value);

/// [ValidationRule] for adding custom validations without the need to create a custom [ValidationRule].
ValidationRule Validate(_ValidateFunction validate, {String? message}) =>
    ValidationRule(
        message: message,
        constraints: [validate],
        validate: (value, arguments) =>
            Future(() => arguments.constraints[0](value)),
        defaultMessage: (arguments) =>
            '"$arguments.property" does not pass validation');
