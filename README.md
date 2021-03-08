# Bandicoot
A simple validation library + API for Dart.

### Example Usage

```dart
import 'package:bandicoot/bandicoot.dart';
import 'package:bandicoot/validators.dart';

class LoginValidator extends Bandicoot {
  String emailAddress;
  String password;

  LoginValidator({this.emailAddress, this.password}) {
    this.setValidators([
      PropertyValidator('emailAddress', validate: [IsEmail()]),
      PropertyValidator('password', validate: [IsPassword()])
    ]);
  }

  @override
  Map toMap() {
    return {emailAddress: this.emailAddress, password: this.password};
  }
}

void main() {
  LoginValidator validator =
      LoginValidator(emailAddress: 'example@gmail.com', password: 'insecure');

  try {
    List<String> errors = validator.validate();
  } catch (e) {
    print(e);
  }
}
```
