import 'package:bandicoot/bandicoot.dart';

/// Convert [string] to a [DateTime].
DateTime? toDate(String string) {
  try {
    return DateTime.parse(string);
  } catch (e) {
    return null;
  }
}

/// [SanitizeRule] for [toDate] sanitizer.
SanitizeRule<String, DateTime?> ToDate() => SanitizeRule(
    constraints: [], sanitize: (value, arguments) => toDate(value));
