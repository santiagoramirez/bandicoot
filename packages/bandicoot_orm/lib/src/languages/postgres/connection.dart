import 'package:bandicoot_orm/src/core/connection_interface.dart';
import 'package:bandicoot_orm/src/utils/sql_builder.dart';

class PostgresConnection<PostgresSQLConnection extends dynamic>
    implements ConnectionInterface {
  PostgresSQLConnection connection;

  PostgresConnection(this.connection);

  Future<void> _query(SQLQuery query) async {
    print(query.query);
    await connection.query(query.query);
  }

  connect() async {
    await connection.open();
  }

  initTable(table, columns) async {
    bool dropTable = true;

    if (dropTable) {
      await _query(SQLBuilder.dropTableIfExists(table));
    }

    await _query(SQLBuilder.createTableIfNotExists(table, columns));
  }

  select(table, columns) async {
    SQLQuery query = SQLBuilder.select(table);

    await connection.mappedResultsQuery(query.query,
        substitutionValues: query.substitutionValues);
  }

  insert(table, values) async {
    SQLQuery query = SQLBuilder.insert(table: table, values: values);

    await connection.mappedResultsQuery(query.query,
        substitutionValues: query.substitutionValues);
  }

  update(table, values, where) async {
    SQLQuery query = SQLBuilder.update(table, values, where);

    await connection.mappedResultsQuery(query.query,
        substitutionValues: query.substitutionValues);
  }
}
