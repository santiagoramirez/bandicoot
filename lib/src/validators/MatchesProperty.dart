import 'package:bandicoot/bandicoot.dart';

bool matchesProperty(dynamic value) {
  return true;
}

class MatchesProperty implements Validator<String> {
  String? message;
  List<dynamic> constraints = [];
  ValidatorFunc<String> validate = matchesProperty;

  MatchesProperty(String property, {this.message}) {
    this.constraints = [property];
  }

  @override
  String defaultMessage(ValidationArguments arguments) {
    return 'Property $arguments.property must match $arguments.constraints[0]';
  }
}
