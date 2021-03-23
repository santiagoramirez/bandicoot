import 'package:bandicoot_orm/src/core/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class UUIDType implements DataTypeInterface {
  @override
  String toSql(SQLDialect dialect) {
    if (dialect == SQLDialect.Postgres) {
      return 'UUID';
    }
    return '';
  }

  @override
  bool validate(dynamic value) => true;
}
