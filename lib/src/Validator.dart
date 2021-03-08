import 'package:bandicoot/bandicoot.dart';

typedef bool ValidatorFunc<T>(T value);

abstract class Validator<InputType> {
  late String? message;
  late List<dynamic> constraints;
  late ValidatorFunc<InputType> validate;

  String defaultMessage(ValidationArguments<InputType> arguments);
}
