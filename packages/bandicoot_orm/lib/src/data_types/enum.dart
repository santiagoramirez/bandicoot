import 'package:bandicoot_orm/src/core/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class EnumType extends DataTypeInterface {
  List<dynamic> _values;
  late String _enumName;

  EnumType(this._values) {
    _enumName = '';
  }

  @override
  String toSqlBefore() =>
      'CREATE TYPE ${_enumName} AS ENUM (${_values.join(', ')})';

  @override
  String toSql(SQLDialect dialect) => _enumName;

  @override
  bool validate(dynamic value) => _values.contains(value);
}
