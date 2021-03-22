import 'package:bandicoot_validation/src/api/sanitize_rule.dart';

/// Convert [string] to a [DateTime].
DateTime? toDate(String string) {
  try {
    return DateTime.parse(string);
  } catch (e) {
    return null;
  }
}

/// [SanitizeRule] for [toDate] sanitizer.
SanitizeRule ToDate() => SanitizeRule(
    constraints: [], sanitize: (value, arguments) => toDate(value));
