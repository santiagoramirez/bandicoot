import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/languages/postgres/query_builder.dart';
import 'package:bandicoot_orm/src/languages/postgres/schema_builder.dart';
import 'package:bandicoot_orm/src/query/query_result.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

class PostgresConnection extends Connection {
  /// instance of [PostgresSQLConnection] from postgres package.
  dynamic postgresSqlConnection;

  PostgresConnection(this.postgresSqlConnection)
      : super(PostgresSchemaBuilder(), PostgresQueryBuilder());

  @override
  getTableStats(table) async {
    List<String> columns = [
      'column_name',
      'data_type',
      'is_nullable',
      'character_maximum_length'
    ];

    QueryResult result = await this.query(PreparedQuery(
        'SELECT ${columns.join(', ')} FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table',
        {'table': table}));

    List<ColumnStats> columnStats = [];

    result.rows.toMapList().forEach((row) {
      columnStats.add(ColumnStats(row['column_name']));
    });

    return TableStats(columnStats.length > 0, columnStats);
  }

  @override
  connect() async {
    await postgresSqlConnection.open();
  }

  @override
  query<TClass>(preparedQuery, [query]) async {
    List<Map<String, Map<String, dynamic>>> mappedRows =
        await postgresSqlConnection.mappedResultsQuery(preparedQuery.query,
            substitutionValues: preparedQuery.substitutionValues);

    List<Map<String, dynamic>> rows = [];

    for (Map<String, Map<String, dynamic>> mappedRow in mappedRows) {
      mappedRow.entries.forEach((entry) {
        rows.add(entry.value);
      });
    }

    print(preparedQuery.query);

    return QueryResult(rows: rows, serializer: query?.serializer);
  }
}
