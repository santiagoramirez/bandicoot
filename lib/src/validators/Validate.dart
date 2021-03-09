import 'package:bandicoot/bandicoot.dart';

typedef bool _ValidateFunction<T>(T value);

Validator<T> Validate<T>(_ValidateFunction validate, {String? message}) =>
    Validator(
        message: message,
        constraints: [validate],
        validate: (value, arguments) {
          return Future(() => arguments.constraints[0](value));
        },
        defaultMessage: (arguments) {
          return '"$arguments.property" does not pass validation';
        });
