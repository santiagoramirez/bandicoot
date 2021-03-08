import 'package:bandicoot/bandicoot.dart';
import 'package:validators/validators.dart';

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
