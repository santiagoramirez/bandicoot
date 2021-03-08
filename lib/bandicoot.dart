import 'package:bandicoot/bandicoot.dart';

export 'src/PropertyValidator.dart';
export 'src/Sanitizer.dart';
export 'src/ValidationArguments.dart';
export 'src/Validator.dart';

class Bandicoot {
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
