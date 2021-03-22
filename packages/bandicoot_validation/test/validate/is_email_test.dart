import 'package:bandicoot_validation/src/validate/is_email.dart';
import 'package:test/test.dart';

void main() {
  test('isEmail returns true for valid emails', () {
    expect(isEmail('example@gmail.com'), equals(true));
    expect(isEmail('example.1@yahoo.com'), equals(true));
    expect(isEmail('example_2@website-with-dash.net'), equals(true));
  });

  test('isEmail returns false for non-emails', () {
    expect(isEmail('examplegmail.com'), equals(false));
    expect(isEmail('EXAMPLE'), equals(false));
    expect(isEmail('Example example'), equals(false));
  });
}
