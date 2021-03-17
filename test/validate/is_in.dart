import 'package:bandicoot/src/api/validation_arguments.dart';
import 'package:bandicoot/src/api/validation_rule.dart';
import 'package:bandicoot/src/validate/is_in.dart';
import 'package:test/test.dart';

void main() {
  test('IsIn.validate() returns true when a value is contained within the list',
      () async {
    List<String> list = ['value1', 'value2', 'value3', 'value4'];
    ValidationRule rule = IsIn(list);
    ValidationArguments arguments = ValidationArguments(
        value: 'value2', values: {}, constraints: [list], property: 'prop1');

    expect(await rule.validate('value2', arguments), equals(true));
  });

  test(
      'IsIn.validate() returns false when value is not contained within the list',
      () async {
    List<String> list = ['value1', 'value3', 'value4'];
    ValidationRule rule = IsIn(list);
    ValidationArguments arguments = ValidationArguments(
        value: 'value2', values: {}, constraints: [list], property: 'prop1');

    expect(await rule.validate('value2', arguments), equals(false));
  });
}
