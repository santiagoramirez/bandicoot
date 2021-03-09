import 'package:bandicoot/bandicoot.dart';

typedef Out SanitizeFunction<In, Out>(
    In value, ValidationArguments<In> arguments);

class SanitizeRule<In, Out> {
  List<dynamic> constraints;
  SanitizeFunction<In, Out> sanitize;

  SanitizeRule({required this.constraints, required this.sanitize});
}
