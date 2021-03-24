import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/languages/postgres/connection.dart';
import 'package:bandicoot_orm/src/query/query.dart';
import 'package:bandicoot_orm/src/query/query_result.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';
import 'package:bandicoot_orm/src/schema_builders/schema_builder.dart';

class _DatabaseType {
  static const Postgres = 'postgres';
}

Connection createConnection(String databaseType, dynamic databaseConnection) {
  switch (databaseType) {
    case _DatabaseType.Postgres:
      return PostgresConnection(databaseConnection);
  }

  throw 'Unsupported database type: "$databaseType"';
}

class Connection {
  SchemaBuilder schemaBuilder;
  QueryBuilder queryBuilder;

  Connection(this.schemaBuilder, this.queryBuilder);

  // Open connection of the chosen database type.
  Future<void> connect() {
    throw UnimplementedError();
  }

  Future<QueryResult<TClass>> query<TClass>(PreparedQuery preparedQuery,
      [Query<TClass>? query]) async {
    throw UnimplementedError();
  }

  Future<QueryResult<TClass>> find<TClass>(FindQuery<TClass> query) async =>
      this.query(queryBuilder.buildSearchQuery(query), query);

  Future<QueryResult<TClass>> insert<TClass>(InsertQuery<TClass> query) async =>
      this.query(queryBuilder.buildInsertQuery(query), query);

  Future<QueryResult<TClass>> update<TClass>(
          UpdateQuery<TClass> query, Serializer<TClass> serializer) async =>
      this.query(queryBuilder.buildUpdateQuery(query), query);

  Future<QueryResult<TClass>> delete<TClass>(DeleteQuery<TClass> query) async =>
      this.query(queryBuilder.buildDeleteQuery(query), query);
}
