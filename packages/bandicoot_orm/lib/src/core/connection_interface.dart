import 'package:bandicoot_orm/src/api/column.dart';

abstract class ConnectionInterface {
  Future<void> connect();
  Future<void> initTable(String table, List<Column> columns);
  Future<void> select(String table, List<String> columns);
  Future<void> insert(String table, Map<String, dynamic> values);
  Future<void> update(String table, Map<String, dynamic> values, dynamic where);
}
