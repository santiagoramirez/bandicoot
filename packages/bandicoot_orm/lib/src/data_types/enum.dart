import 'package:bandicoot_orm/src/core/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class EnumType extends DataTypeInterface {
  List<dynamic> _values;

  EnumType(this._values);

  @override
  String toSql(SQLDialect dialect) => 'VARCHAR(20)';

  @override
  bool validate(dynamic value) => _values.contains(value);
}
