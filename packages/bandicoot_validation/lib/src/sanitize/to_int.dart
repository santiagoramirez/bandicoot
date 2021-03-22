import 'package:bandicoot_validation/src/api/sanitize_rule.dart';

/// Convert [string] to an [int].
num toInt(String string, {int? radix: 10}) {
  try {
    return int.parse(string, radix: radix);
  } catch (e) {
    try {
      return double.parse(string).toInt();
    } catch (e) {
      return double.nan;
    }
  }
}

/// [SanitizeRule] for [toInt] sanitizer.
SanitizeRule ToInt({int? radix = 10}) => SanitizeRule(
    constraints: [radix],
    sanitize: (value, arguments) =>
        toInt(value, radix: arguments.constraints[0]));
