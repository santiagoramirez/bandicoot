class ValidationArguments {
  String property;
  dynamic value;
  Map values;

  List<dynamic> constraints = [];

  ValidationArguments(
      {required this.property,
      required this.value,
      required this.values,
      required this.constraints}) {}
}
