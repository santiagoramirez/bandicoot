import 'package:bandicoot/bandicoot.dart';

bool isString(String value) => value is String;

Validator<String> IsString({String? message}) => Validator(
    message: message,
    constraints: [],
    validate: (value, arguments) {
      return Future(() => isString(value));
    },
    defaultMessage: (arguments) {
      return '"$arguments.property" must be a valid string';
    });
