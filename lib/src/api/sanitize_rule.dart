import 'package:bandicoot/src/api/validation_arguments.dart';

typedef dynamic _Sanitize(dynamic value, ValidationArguments arguments);

class SanitizeRule {
  List<dynamic> constraints;
  _Sanitize sanitize;

  SanitizeRule({required this.constraints, required this.sanitize});
}
