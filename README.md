# Bandicoot
A simple validation library + API for Dart.

Currently a work in progress.

```sh
pub add bandicoot
```

### Example Usage

```dart
import 'package:bandicoot/bandicoot.dart';

PasswordRules passwordRules = PasswordRules();

Validator RegisterUserValidator = Validator()
  ..property(
    name:'firstName',
    validators: [IsString()]
  )
  ..property(
    name:'lastName',
    validators: [IsString()]
  )
  ..property(
    name: 'emailAddress',
    validators: [IsEmail()]
  )
  ..property(
    name: 'confirmEmailAddress',
    validators: [MatchesProperty('emailAddress')]
  )
  ..property(
    name: 'password',
    validators: [IsPassword(passwordRules)]
  )
  ..property(
    name:'confirmPassword',
    validators: [MatchesProperty('password')]
  );

void main() {
  Map registerData = {
    'emailAddress': ;
    'confirmEmailAddress': 'example@gmail.com';
    'password': 'insecure';
    'confirmPassword': 'not the same';
  }

  List<String> errors = RegisterUserValidator.validate(registerData);

  if (errors.length > 0) {
    // Errors have been returned
  } else {
    // Error free!
  }
}
```
