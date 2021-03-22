import 'package:bandicoot_validation/src/api/sanitize_rule.dart';

/// Convert [input] to a [String].
String toString(input) {
  if (input == null || (input is List && input.length == 0)) {
    input = '';
  }
  return input.toString();
}

/// [SanitizeRule] for [toString] sanitizer.
SanitizeRule ToString() => SanitizeRule(
    constraints: [], sanitize: (value, arguments) => toString(value));
