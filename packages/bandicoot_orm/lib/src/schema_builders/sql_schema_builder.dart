import 'package:bandicoot_orm/src/enums/sql_dialect.dart';
import 'package:bandicoot_orm/src/query_builder.dart';
import 'package:bandicoot_orm/src/schema_builder.dart';

class SQLSchemaBuilder implements SchemaBuilder {
  @override
  buildCreateTable(entity) => PreparedQuery(
      'CREATE TABLE IF NOT EXISTS "${entity.table}" (${entity.columns.map(buildColumnFragment).join(', ')})');

  @override
  buildAddColumn(entity, column) => PreparedQuery(
      'ALTER TABLE "${entity.table}" ADD COLUMN ${buildColumnFragment(column)}');

  @override
  buildUpdateColumn(entity, column) => PreparedQuery(
      'ALTER TABLE "${entity.table}" ALTER COLUMN ${buildColumnFragment(column)}'
          .replaceAll('SERIAL', '')
          .replaceAll('PRIMARY KEY', ''));

  @override
  buildDropColumn(entity, columnName) => PreparedQuery(
      'ALTER TABLE "${entity.table}" DROP COLUMN "${columnName}"');

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
