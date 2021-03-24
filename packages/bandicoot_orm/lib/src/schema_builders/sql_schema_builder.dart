import 'package:bandicoot_orm/src/enums/sql_dialect.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';
import 'package:bandicoot_orm/src/schema_builders/schema_builder.dart';

class SQLSchemaBuilder implements SchemaBuilder {
  @override
  buildCreateTable(entity) {
    return PreparedQuery(
        'CREATE TABLE IF NOT EXISTS "${entity.table}" (${entity.columns.map(buildColumnFragment).join(', ')})');
  }

  @override
  buildColumnFragment(column) {
    String columnString =
        '"${column.name}" ${column.type.toSql(SQLDialect.Postgres)}';

    if (column.unique) columnString = '$columnString UNIQUE';
    if (column.index) columnString = '$columnString INDEX';
    if (!column.nullable) columnString = '$columnString NOT NULL';

    return columnString;
  }
}
