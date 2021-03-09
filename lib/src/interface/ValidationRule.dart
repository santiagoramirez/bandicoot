import 'package:bandicoot/bandicoot.dart';

typedef Future<bool> ValidationFunction<T>(
    T value, ValidationArguments arguments);

typedef String DefaultValidationMessage<T>(ValidationArguments<T> arguments);

class ValidationRule<T> {
  String? message;
  List<dynamic> constraints;
  ValidationFunction<T> validate;
  DefaultValidationMessage<T> defaultMessage;

  ValidationRule(
      {this.message,
      required this.constraints,
      required this.validate,
      required this.defaultMessage});
}
