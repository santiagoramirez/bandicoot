import 'package:bandicoot_validation/src/password_rules.dart';
import 'package:test/test.dart';

PasswordRules onlyLowercase = PasswordRules(
    min: 4,
    max: 10,
    requireLowercase: true,
    requireUppercase: false,
    requireNumbers: false,
    requireSpecialCharacters: false);

PasswordRules allRules = PasswordRules(
    min: 4,
    max: 10,
    requireLowercase: true,
    requireUppercase: true,
    requireNumbers: true,
    requireSpecialCharacters: true);

void main() {
  test(
      'when only lowercase required, regex should only allow strings which are all lowercase',
      () {
    expect(onlyLowercase.regexAsString, equals('^(?=.*[a-z])[a-z]{4,10}\$'));

    expect(onlyLowercase.regex.hasMatch('abcde'), equals(true));
    expect(onlyLowercase.regex.hasMatch('abcdefg'), equals(true));
    expect(onlyLowercase.regex.hasMatch('abc'), equals(false));
    expect(onlyLowercase.regex.hasMatch('abc2'), equals(false));
  });

  test(
      'when all rules required, regex should only allow strings which conform to constraints',
      () {
    expect(
        allRules.regexAsString,
        equals(
            '^(?=.*[a-z])(?=.*[A-Z])(?=.*[\\d])(?=.*[!@#\$%^&*(){}\\[\\]|:;\'"<,>.?\\/])[a-zA-Z\\d!@#\$%^&*(){}\\[\\]|:;\'"<,>.?\\/]{4,10}\$'));

    expect(allRules.regex.hasMatch('abcABC123@'), equals(true));
    expect(allRules.regex.hasMatch('123abcDEF\$'), equals(true));
    expect(allRules.regex.hasMatch('abcABC123'), equals(false));
    expect(allRules.regex.hasMatch('abcABC123 @'), equals(false));
  });
}
