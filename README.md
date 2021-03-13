# bandicoot

## Introduction

Bandicoot is a validation schema library that makes is easy to create validation schemas and run those validations against a provided `Map`.
Bandicoot also enables the ability to sanitize map values as well.

## Creating a Schema

To create a schema, all you have to do is initiate a new `Validator` class and add the validation rules, and/or sanitization rules, you would like to apply for each property.

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

## Validation Rules

| Validation Rule | Description |
| ---- | ----------- |
| `Equals(String value)` | Check if a property is equal to a specific value. |
| `IsEmail()` | Check if a property is a valid email address. |
| `IsEnum(Enum)` | Check if a property is a valid enum. |
| `IsInt()` | Check if a property is an `int` type.|
| `IsPassword(PasswordRules rules)` | Check if a property matches password rules. |
| `IsString()` | Check if a property is a string. |
| `IsUUID(String version = 'all')` | Check if a property is a valid uuid. |
| `MatchesProperty(String property)` | Check if a property matches the value of another property |
| `Matches(String pattern)` | Check if a property matches a regex. |
| `Validate(ValidateFunction validate)` | Check if a property passes a custom validation. |

## Sanitization Rules

| Sanitization Rule | Description |
| ---- | ----------- |
| `ToDate()` | Coerce a value into a `DateTime` |
| `ToInt()` | Coerce a string value into a `num` |
| `ToString()` | Coerce a non-string value into a `String` |

## Extensibility
With Bandicoot, creating custom validations and sanitizers couldn't be easier. All you need to do is create a function that returns a `ValidationRule` or a `SanitizeRule`.

### Sample `ValidationRule`

```dart
import 'package:bandicoot/bandicoot.dart';

ValidationRule IsIn(List<dynamic> array, {String? message}) => ValidationRule(
    message: message,
    constraints: [array],
    validate: (value, arguments) =>
        Future(() => arguments.constraints[0].contains(value)),
    defaultMessage: (arguments) {
      String property = arguments.property;
      String arrayValues = arguments.constraints[0].join(', ');
      return "$property must be one of the following values: $arrayValues";
    });
```

### Sample `SanitizeRule`

```dart
import 'package:bandicoot/src/api/sanitize_rule.dart';

DateTime? toDate(String string) {
  try {
    return DateTime.parse(string);
  } catch (e) {
    return null;
  }
}

SanitizeRule ToDate() => SanitizeRule(
    constraints: [], sanitize: (value, arguments) => toDate(value));
```
