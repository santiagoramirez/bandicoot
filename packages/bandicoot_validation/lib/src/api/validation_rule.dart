import 'package:bandicoot_validation/src/api/validation_arguments.dart';

typedef Future<bool> _Validate(dynamic value, ValidationArguments arguments);

typedef String _DefaultMessage(ValidationArguments arguments);

class ValidationRule {
  String? message;
  List<dynamic> constraints;
  _Validate validate;
  _DefaultMessage defaultMessage;

  ValidationRule(
      {required this.message,
      required this.constraints,
      required this.validate,
      required this.defaultMessage});
}
