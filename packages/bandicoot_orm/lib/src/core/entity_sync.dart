import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/core/entity.dart';

/// Sync an [Entity] definition with existing database
/// tables and columns
class EntitySync {
  static Future<void> synchronize(Entity entity, Connection connection) async {
    TableStats tableStats = await connection.getTableStats(entity.table);

    if (!tableStats.isExisting) {
      // Create table if it does not already exist.
      await connection.query(connection.schemaBuilder.buildCreateTable(entity));
      return;
    }

    for (Column column in entity.columns) {
      if (!tableStats.hasColumn(column.name)) {
        // Add column if it does not already exist.
        await connection
            .query(connection.schemaBuilder.buildAddColumn(entity, column));
      } else {
        /// TODO: Add ability to update column only if it has different settings.
      }
    }

    for (ColumnStats stats in tableStats.columnStats) {
      try {
        entity.columns.firstWhere((c) => c.name == stats.name);
      } catch (e) {
        // Table column not found in entity so should be removed.
        await connection.query(
            connection.schemaBuilder.buildDropColumn(entity, stats.name));
      }
    }
  }
}
