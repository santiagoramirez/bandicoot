import 'package:bandicoot_validation/src/api/validation_rule.dart';

ValidationRule IsIn(List<dynamic> array, {String? message}) => ValidationRule(
    message: message,
    constraints: [array],
    validate: (value, arguments) =>
        Future(() => arguments.constraints[0].contains(value)),
    defaultMessage: (arguments) {
      String property = arguments.property;
      String arrayValues = arguments.constraints[0].join(', ');
      return '"$property" must be one of the following values: $arrayValues';
    });
