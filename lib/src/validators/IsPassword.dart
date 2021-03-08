import 'package:bandicoot/bandicoot.dart';

bool isPassword(String value) => true;

class IsPassword implements Validator<String> {
  String? message;
  List<dynamic> constraints = [];
  ValidatorFunc<String> validate = isPassword;

  IsPassword({this.message});

  @override
  String defaultMessage(ValidationArguments arguments) {
    return 'Invalid password of $arguments.value';
  }
}
