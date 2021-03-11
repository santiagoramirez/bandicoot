import 'package:bandicoot/bandicoot.dart';

class ValidatorMixin {
  late Validator validator;

  Future<List<String>> validate({List<String>? properties}) async =>
      await this.validator.validate(this.toMap(), properties: properties);

  Map sanitize() {
    Map sanitizedMap = this.validator.sanitize(this.toMap());
    this.toClass(sanitizedMap);
    return sanitizedMap;
  }

  /// Used by [validate()] and [sanitize()] to validate class values.
  Map toMap() {
    throw UnimplementedError(
        'If using validate() or sanitize(), toMap() must be implemented');
  }

  /// Used by [sanitize()] to write sanitized values to the class instance.
  void toClass(Map map) {
    throw UnimplementedError(
        'If using sanitize(), toClass(map) must be implemented');
  }
}
