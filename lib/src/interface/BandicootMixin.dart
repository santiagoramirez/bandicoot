import 'package:bandicoot/bandicoot.dart';

class BandicootMixin {
  late Bandicoot validator;

  List<String> validate({List<String>? properties}) =>
      this.validator.validate(this.toMap(), properties: properties);

  Map sanitize() {
    Map sanitizedMap = this.validator.sanitize(this.toMap());
    this.toClass(sanitizedMap);
    return sanitizedMap;
  }

  /// Used by [BandicootMixin.validate()] to validate class values.
  Map toMap() {
    throw UnimplementedError();
  }

  /// Used by [BandicootMixin.sanitize()] to write sanitized values to the class instance.
  void toClass(Map map) {
    throw UnimplementedError();
  }
}
