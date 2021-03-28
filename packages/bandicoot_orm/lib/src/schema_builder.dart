import 'package:bandicoot_orm/src/column.dart';
import 'package:bandicoot_orm/src/entity.dart';
import 'package:bandicoot_orm/src/query_builder.dart';

abstract class SchemaBuilder {
  PreparedQuery buildCreateTable(Entity entity);
  PreparedQuery buildAddColumn(Entity entity, Column column);
  PreparedQuery buildUpdateColumn(Entity entity, Column column);
  PreparedQuery buildDropColumn(Entity entity, String columnName);
  String buildColumnFragment(Column column);
}
