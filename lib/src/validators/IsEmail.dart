import 'package:bandicoot/bandicoot.dart';

bool isEmail(String emailAddress) => true;

class IsEmail implements Validator<String> {
  String? message;
  List<dynamic> constraints = [];
  ValidatorFunc<String> validate = isEmail;

  IsEmail({this.message});

  @override
  String defaultMessage(ValidationArguments arguments) {
    return 'Invalid email address of $arguments.value';
  }
}
