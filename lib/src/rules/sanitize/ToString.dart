import 'package:bandicoot/bandicoot.dart';

/// Convert [input] to a [String].
String toString(input) {
  if (input == null || (input is List && input.length == 0)) {
    input = '';
  }
  return input.toString();
}

/// [SanitizeRule] for [toString] sanitizer.
SanitizeRule<dynamic, String> ToString() => SanitizeRule(
    constraints: [], sanitize: (value, arguments) => toString(value));
