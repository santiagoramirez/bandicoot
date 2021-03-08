import 'package:bandicoot/bandicoot.dart';

class Validate implements Validator<dynamic> {
  String? message;
  List<dynamic> constraints = [];
  late ValidatorFunc<dynamic> validate;

  Validate(this.validate, {this.message});

  String defaultMessage(ValidationArguments arguments) {
    return '$arguments.property';
  }
}
