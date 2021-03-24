import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/languages/postgres/query_builder.dart';
import 'package:bandicoot_orm/src/languages/postgres/schema_builder.dart';
import 'package:bandicoot_orm/src/query/query_result.dart';

class PostgresConnection extends Connection {
  /// instance of [PostgresSQLConnection] from postgres package.
  dynamic postgresSqlConnection;

  PostgresConnection(this.postgresSqlConnection)
      : super(PostgresSchemaBuilder(), PostgresQueryBuilder());

  @override
  connect() async {
    await postgresSqlConnection.open();
  }

  @override
  query<TClass>(preparedQuery, [query]) async {
    print(preparedQuery.query);
    await postgresSqlConnection.mappedResultsQuery(preparedQuery.query,
        substitutionValues: preparedQuery.substitutionValues);

    return QueryResult(rows: [], serializer: query?.serializer);
  }
}
