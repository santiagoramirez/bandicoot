import 'package:bandicoot/bandicoot.dart';

class PropertyValidator {
  late String property;
  late List<Validator>? validate;
  late List<Sanitizer>? sanitize;
  late List<String>? groups;

  PropertyValidator(
    String property, {
    List<Validator>? validate,
    List<Sanitizer>? sanitize,
    List<String>? groups,
  }) {
    this.property = property;
    this.validate = validate;
    this.sanitize = sanitize;
    this.groups = groups;
  }
}
