import 'package:bandicoot_orm/src/core/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class UUIDType extends DataTypeInterface {
  @override
  String toSql(SQLDialect dialect) {
    if (dialect == SQLDialect.Postgres) {
      return 'UUID';
    }
    return '';
  }
}
