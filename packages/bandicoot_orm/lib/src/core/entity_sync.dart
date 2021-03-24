import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

/// Sync an [Entity] definition with existing database
/// tables and columns
class EntitySync {
  static Future<void> synchronize(Entity entity, Connection connection) async {
    PreparedQuery createTableQuery =
        connection.schemaBuilder.buildCreateTable(entity);

    await connection.query(createTableQuery);

    // bool isExisting = await isTableExisting(entity.table);

    // if (!isExisting) {
    //   return await initTable();
    // }

    // for (Column column in entity.columns) {
    //   await syncColumn(column);
    // }
  }

  /// Create a new table, plus columns, that did not
  /// previously exist.
  static Future<void> initTable() async {}

  // Create a new column that did not previously exist on
  // an existing table schema.
  static Future<void> initColumn(Column column) async {}

  /// Determine if column is in sync with table column.
  /// Make alterations if needed.
  static Future<void> syncColumn(Column column) async {
    bool isExisting = await isColumnExisting(column);

    if (!isExisting) {
      return await initColumn(column);
    }

    // Do stuff to alter the column to match the entity.
  }

  static Future<bool> isTableExisting(String table) async {
    // Do stuff to determine if the table exists.
    return true;
  }

  static Future<bool> isColumnExisting(Column column) async {
    // Do stuff to determine if the column exists.
    return false;
  }
}
