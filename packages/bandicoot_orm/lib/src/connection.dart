import 'package:bandicoot_orm/bandicoot_orm.dart';
import 'package:bandicoot_orm/src/entity.dart';
import 'package:bandicoot_orm/src/languages/postgres/connection.dart';
import 'package:bandicoot_orm/src/query.dart';
import 'package:bandicoot_orm/src/query_builder.dart';
import 'package:bandicoot_orm/src/schema_builder.dart';

class _DatabaseType {
  static const Postgres = 'postgres';
}

Connection createConnection(String type, dynamic connection) {
  switch (type) {
    case _DatabaseType.Postgres:
      return PostgresConnection(connection);
  }

  throw 'Unsupported database type: "$type"';
}

Connection getConnection([String instance = BandicootORM.defaultInstance]) {
  if (BandicootORM.connections.containsKey(instance)) {
    return BandicootORM.connections[instance]!;
  }
  throw 'Invalid connection instance';
}

class TableStats {
  bool isExisting;
  List<ColumnStats> columnStats;

  TableStats(this.isExisting, this.columnStats);

  bool hasColumn(String name) {
    try {
      columnStats.firstWhere((c) => c.name == name);
      return true;
    } catch (err) {
      return false;
    }
  }
}

class ColumnStats {
  String name;

  ColumnStats(this.name);
}

class Connection {
  SchemaBuilder schemaBuilder;
  QueryBuilder queryBuilder;

  Connection(this.schemaBuilder, this.queryBuilder);

  // Open connection of the chosen database type.
  Future<void> connect() {
    throw UnimplementedError();
  }

  Future<TableStats> getTableStats(String table) {
    throw UnimplementedError();
  }

  Future<QueryResult<TClass>> query<TClass>(PreparedQuery preparedQuery,
      [Query<TClass>? query]) async {
    throw UnimplementedError();
  }

  Future<QueryResult<TClass>> find<TClass>(FindQuery<TClass> query) async =>
      this.query(queryBuilder.buildFindQuery(query), query);

  Future<QueryResult<TClass>> insert<TClass>(InsertQuery<TClass> query) async =>
      this.query(queryBuilder.buildInsertQuery(query), query);

  Future<QueryResult<TClass>> update<TClass>(
          UpdateQuery<TClass> query, Serializer<TClass> serializer) async =>
      this.query(queryBuilder.buildUpdateQuery(query), query);

  Future<QueryResult<TClass>> delete<TClass>(DeleteQuery<TClass> query) async =>
      this.query(queryBuilder.buildDeleteQuery(query), query);
}
