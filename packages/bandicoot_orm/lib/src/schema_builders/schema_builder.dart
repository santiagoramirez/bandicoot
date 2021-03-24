import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

abstract class SchemaBuilder {
  PreparedQuery buildCreateTable(Entity entity);
  String buildColumnFragment(Column column);
}
