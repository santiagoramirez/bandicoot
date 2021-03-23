import 'package:bandicoot_orm/src/connection/connection_interface.dart';
import 'package:bandicoot_orm/src/schema_builders/postgres_schema_builder.dart';
import 'package:bandicoot_orm/src/utils/sql_builder.dart';

class PostgresConnection<PostgresSQLConnection extends dynamic>
    implements ConnectionInterface {
  PostgresSQLConnection connection;
  PostgresSchemaBuilder schemaBuilder = PostgresSchemaBuilder();

  PostgresConnection(this.connection);

  connect() async => await connection.open();

  initTable(table, columns) async {
    bool dropTable = true;

    if (dropTable) {
      await query(SQLBuilder.dropTableIfExists(table).query);
    }

    await query(SQLBuilder.createTableIfNotExists(table, columns).query);
  }

  query(query) async => await connection.query(query);

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
