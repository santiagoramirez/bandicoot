class ValidationArguments<ValueType> {
  String property;
  ValueType value;
  Map values;

  List<dynamic> constraints = [];

  ValidationArguments(
      {required this.property,
      required this.value,
      required this.values,
      required this.constraints}) {}
}
