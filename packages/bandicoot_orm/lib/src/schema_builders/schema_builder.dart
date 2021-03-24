import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

abstract class SchemaBuilder {
  PreparedQuery buildCreateTable(Entity entity);
  PreparedQuery buildAddColumn(Entity entity, Column column);
  PreparedQuery buildUpdateColumn(Entity entity, Column column);
  PreparedQuery buildDropColumn(Entity entity, String columnName);
  String buildColumnFragment(Column column);
}
