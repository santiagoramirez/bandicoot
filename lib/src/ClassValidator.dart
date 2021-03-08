import 'package:bandicoot/bandicoot.dart';

class ClassValidator {
  late List<PropertyValidator> validators;

  Validator(List<PropertyValidator> validators) {
    this.validators = validators;
  }

  List<String> validate() {
    this.validators.forEach((propertyValidator) {});

    return [];
  }

  List<String> validateProperty(String property) {
    return [];
  }

  Map toMap() {
    throw UnimplementedError();
  }
}
