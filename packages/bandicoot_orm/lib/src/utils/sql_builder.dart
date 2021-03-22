import 'package:bandicoot_orm/src/api/column.dart';

import './sql_builder_fragments.dart';

class SQLQuery {
  String query;
  Map<String, dynamic>? substitutionValues;

  SQLQuery(this.query, [this.substitutionValues]);
}

class SQLBuilder {
  static SQLQuery dropTableIfExists(String table) =>
      SQLQuery('DROP TABLE IF EXISTS "$table"');

  static SQLQuery createTableIfNotExists(String table, List<Column> columns) =>
      SQLCreateTableBuilder(table, columns).toSqlQuery();

  static SQLQuery select(String table, {List? columns, dynamic? where}) =>
      SQLSelectBuilder(table, columns, where).toSqlQuery();

  static SQLQuery insert({required table, required values}) =>
      SQLInsertBuilder(table, values).toSqlQuery();

  static SQLQuery update(table, values, where) =>
      SQLUpdateBuilder(table, values, where).toSqlQuery();
}
