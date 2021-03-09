import 'package:bandicoot/bandicoot.dart';

bool matchesProperty(String property1, String property2, Map map) {
  if (map[property1] == map[property2]) {
    return true;
  }
  return false;
}

Validator<String> MatchesProperty(String property, {String? message}) =>
    Validator(
        message: message,
        constraints: [property],
        validate: (value, arguments) {
          return Future(() => matchesProperty(
              arguments.property, arguments.constraints[0], arguments.values));
        },
        defaultMessage: (arguments) {
          return '"$arguments.property" must match "$arguments.constraints[0]"';
        });
