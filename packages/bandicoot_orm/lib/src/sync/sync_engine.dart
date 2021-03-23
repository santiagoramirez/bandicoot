import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/api/entity.dart';
import 'package:bandicoot_orm/src/connection/connection_interface.dart';
import 'package:bandicoot_orm/src/schema_builders/schema_builder_interface.dart';

/// Sync an [Entity] definition with existing database
/// tables and columns
class SyncEngine {
  final Entity entity;
  final SchemaBuilderInterface schemaBuilder;
  final ConnectionInterface connection;

  const SyncEngine(this.entity, this.connection, this.schemaBuilder);

  Future<void> sync() async {
    bool isExisting = await isTableExisting(entity.table);

    if (!isExisting) {
      return await initTable();
    }

    for (Column column in entity.columns) {
      await syncColumn(column);
    }
  }

  /// Create a new table, plus columns, that did not
  /// previously exist.
  Future<void> initTable() async {}

  // Create a new column that did not previously exist on
  // an existing table schema.
  Future<void> initColumn(Column column) async {}

  /// Determine if column is in sync with table column.
  /// Make alterations if needed.
  Future<void> syncColumn(Column column) async {
    bool isExisting = await isColumnExisting(column);

    if (!isExisting) {
      return await this.initColumn(column);
    }

    // Do stuff to alter the column to match the entity.
  }

  Future<bool> isTableExisting(String table) async {
    // Do stuff to determine if the table exists.
    return true;
  }

  Future<bool> isColumnExisting(Column column) async {
    // Do stuff to determine if the column exists.
    return false;
  }
}
