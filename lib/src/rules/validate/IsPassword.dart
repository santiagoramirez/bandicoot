import 'package:bandicoot/bandicoot.dart';

class PasswordRules {
  int? min = 15;
  int? max = 20;
  bool? requireLowercase = true;
  bool? requireUppercase = true;
  bool? requireSpecialCharacters = true;
  String? specialCharacters = '!@#\$%^&*(){}[]|\:;\'"<,>.?/';

  PasswordRules(
      {this.min,
      this.max,
      this.requireLowercase,
      this.requireUppercase,
      this.requireSpecialCharacters,
      this.specialCharacters});
}

bool isPassword(String value, PasswordRules rules) => true;

ValidationRule<String> IsPassword(PasswordRules rules, {String? message}) =>
    ValidationRule(
        message: message,
        constraints: [rules],
        validate: (value, arguments) {
          return Future(() => isPassword(value, arguments.constraints[0]));
        },
        defaultMessage: (arguments) {
          return '"$arguments.property" must be a valid password';
        });
