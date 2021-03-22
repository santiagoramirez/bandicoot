import 'package:bandicoot_orm/src/core/data_type.dart';

class EnumType extends DataTypeInterface {
  List<dynamic> _values;

  EnumType(this._values);

  @override
  String toSql() => 'VARCHAR(20)';

  @override
  bool validate(dynamic value) => _values.contains(value);
}
