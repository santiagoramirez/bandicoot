import 'package:bandicoot_orm/src/column.dart';
import 'package:bandicoot_orm/src/connection.dart';
import 'package:bandicoot_orm/src/entity.dart';

/// Sync an [Entity] definition with existing database
/// tables and columns
class EntitySync {
  static Future<void> synchronize(Entity entity, Connection connection) async {
    TableStats tableStats = await connection.getTableStats(entity.table);

    if (!tableStats.isExisting) {
      await connection.query(connection.schemaBuilder.buildCreateTable(entity));
      return;
    }

    for (Column column in entity.columns) {
      if (!tableStats.hasColumn(column.name)) {
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
        await connection.query(
            connection.schemaBuilder.buildDropColumn(entity, stats.name));
      }
    }
  }
}
