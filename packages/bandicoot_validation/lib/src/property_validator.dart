import 'package:bandicoot_validation/src/sanitize_rule.dart';
import 'package:bandicoot_validation/src/validation_rule.dart';

class PropertyValidator {
  late String property;
  late bool require;
  late List<ValidationRule> validations;
  late List<SanitizeRule> sanitizers;
  late List<String> groups;

  PropertyValidator({
    required String name,
    bool? require,
    List<ValidationRule>? validations,
    List<SanitizeRule>? sanitizers,
    List<String>? groups,
  }) {
    this.property = name;
    this.require = require ?? false;
    this.validations = validations ?? [];
    this.sanitizers = sanitizers ?? [];
    this.groups = groups ?? [];
  }
}
