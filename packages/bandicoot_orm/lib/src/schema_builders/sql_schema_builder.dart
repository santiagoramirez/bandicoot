import 'package:bandicoot_orm/src/schema_builders/schema_builder_interface.dart';

class SQLSchemaBuilder implements SchemaBuilderInterface {
  const SQLSchemaBuilder();

  String buildCreateTable() {
    return '';
  }

  String buildColumn() {
    return '';
  }
}
