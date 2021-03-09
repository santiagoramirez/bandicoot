import 'package:bandicoot/bandicoot.dart';

class PropertyValidator {
  late String name;
  late List<ValidationRule>? validations;
  late List<SanitizeRule>? sanitizers;
  late List<String>? groups;

  PropertyValidator({
    required String name,
    List<ValidationRule>? validations,
    List<SanitizeRule>? sanitizers,
    List<String>? groups,
  }) {
    this.name = name;
    this.validations = validations;
    this.sanitizers = sanitizers;
    this.groups = groups;
  }
}
