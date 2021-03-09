import 'package:bandicoot/bandicoot.dart';

num toInt(String intString, {int? radix: 10}) => 1;

SanitizeRule<String, num> ToInt({int? radix = 10}) => SanitizeRule(
    constraints: [radix],
    sanitize: (value, arguments) {
      return toInt(value, radix: radix);
    });
