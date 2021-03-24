import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/schema_builders/schema_builder.dart';

//  initTable(table, columns) async {
//     bool dropTable = true;

//     if (dropTable) {
//       await query(SQLBuilder.dropTableIfExists(table).query);
//     }

//     await query(SQLBuilder.createTableIfNotExists(table, columns).query);
//   }

/// Sync an [Entity] definition with existing database
/// tables and columns
class SyncEngine {
  final Entity entity;
  final SchemaBuilder schemaBuilder;
  final Connection connection;

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
