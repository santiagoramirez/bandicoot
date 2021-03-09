import 'package:bandicoot/bandicoot.dart';

bool isEnum<T>(T value, T enumType) => value is T;

ValidationRule<T> IsEnum<T>(T enumType, {String? message}) => ValidationRule(
    message: message,
    constraints: [enumType],
    validate: (value, arguments) {
      return Future(() => isEnum(value, arguments.constraints[0]));
    },
    defaultMessage: (arguments) {
      return '"$arguments.property" must be a valid enum of "$arguments.constraints[0]"';
    });
