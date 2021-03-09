# Bandicoot
A simple validation library + API for Dart.

Currently a work in progress.

### Example Usage


```dart
Bandicoot RegisterUserValidator = Bandicoot()
  ..property('firstName', validators: [IsString()])
  ..property('lastName', validators: [IsString()])
  ..property('emailAddress', validators: [IsEmail()])
  ..property('confirmEmailAddress', validators: [MatchesProperty('emailAddress')])
  ..property('password', validators: [IsPassword()])
  ..property('confirmPassword', validators: [MatchesProperty('password')]);

void main() {
  Map<String, dynamic> registerData = new Map();

  registerData['emailAddress'] = 'example@gmail.com';
  registerData['confirmEmailAddress'] = 'example@gmail.com';
  registerData['password'] = 'insecure';
  registerData['confirmPassword'] = 'not the same';

  List<String> errors = RegisterUserValidator.validate(registerData);

  if (errors.length > 0) {
    // Errors have been returned
  } else {
    // Error free!
  }
}
```
