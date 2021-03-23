import 'package:bandicoot_orm/src/api/column.dart';

abstract class ConnectionInterface<TSchemaBuilder> {
  Future<void> connect();
  Future<void> initTable(String table, List<Column> columns);
  Future<void> query(String query);
  Future<void> select(String table, List<String> columns);
  Future<void> insert(String table, Map<String, dynamic> values);
  Future<void> update(String table, Map<String, dynamic> values, dynamic where);
}
