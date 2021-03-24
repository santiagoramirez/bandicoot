import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/query/query.dart';
import 'package:bandicoot_orm/src/query/query_result.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';
import 'package:bandicoot_orm/src/schema_builders/schema_builder.dart';

class Connection {
  SchemaBuilder schemaBuilder;
  QueryBuilder queryBuilder;

  Connection(this.schemaBuilder, this.queryBuilder);

  // Open connection of the chosen database type.
  Future<void> connect() {
    throw UnimplementedError();
  }

  Future<QueryResult<TClass>> query<TClass>(
      Query<TClass> query, PreparedQuery preparedQuery) async {
    throw UnimplementedError();
  }

  Future<QueryResult<TClass>> find<TClass>(FindQuery<TClass> query) async =>
      this.query(query, queryBuilder.buildSearchQuery(query));

  Future<QueryResult<TClass>> insert<TClass>(InsertQuery<TClass> query) async =>
      this.query(query, queryBuilder.buildInsertQuery(query));

  Future<QueryResult<TClass>> update<TClass>(
          UpdateQuery<TClass> query, Serializer<TClass> serializer) async =>
      this.query(query, queryBuilder.buildUpdateQuery(query));

  Future<QueryResult<TClass>> delete<TClass>(DeleteQuery<TClass> query) async =>
      this.query(query, queryBuilder.buildDeleteQuery(query));
}
