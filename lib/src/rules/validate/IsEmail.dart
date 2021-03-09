import 'package:bandicoot/bandicoot.dart';

bool isEmail(String emailAddress) => true;

ValidationRule<String> IsEmail({String? message}) => ValidationRule(
    message: message,
    constraints: [],
    validate: (value, arguments) {
      return Future(() => isEmail(value));
    },
    defaultMessage: (arguments) {
      return '"$arguments.property" must be a valid email address';
    });
