import 'package:bandicoot/bandicoot.dart';

typedef Future<bool> Validate<T>(T value, ValidationArguments arguments);

typedef String DefaultMessage<T>(ValidationArguments<T> arguments);

class Validator<T> {
  String? message;
  List<dynamic> constraints;
  Validate<T> validate;
  DefaultMessage<T> defaultMessage;

  Validator(
      {this.message,
      required this.constraints,
      required this.validate,
      required this.defaultMessage});
}
