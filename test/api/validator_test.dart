import 'package:bandicoot/bandicoot.dart' as Bandicoot;
import 'package:test/test.dart';

Bandicoot.Validator TestValidator = Bandicoot.Validator()
  ..property(name: 'isEmailTest', validations: [Bandicoot.IsEmail()])
  ..property(name: 'isInTest', validations: [
    Bandicoot.IsIn(['test'])
  ])
  ..property(name: 'isStringTest', validations: [Bandicoot.IsString()]);

void main() {
  test('Validator.validate() returns empty list when all values are valid',
      () async {
    List<String> errors = await TestValidator.validate({
      'isEmailTest': 'test@gmail.com',
      'isInTest': 'test',
      'isStringTest': 'test'
    });

    expect(errors.length, equals(0));
  });

  test('Validator.validate() returns three errors when all values are invalid',
      () async {
    List<String> errors = await TestValidator.validate({
      'isEmailTest': 'testgmail.com',
      'isInTest': 'nottest',
      'isStringTest': 23
    });

    expect(errors.length, equals(3));
  });
}
