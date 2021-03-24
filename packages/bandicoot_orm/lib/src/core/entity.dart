import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/core/data_type.dart';

abstract class Serializer<TClass> {
  TClass toClass(Map<String, dynamic> values);
  Map<String, dynamic> toTableRow(TClass model);
}

class Entity<TClass> {
  String table;
  List<Column> columns = [];
  Serializer<TClass> serializer;

  Entity({required this.table, required this.serializer});

  void column(
      {required String name, required DataTypeInterface type, bool? unique}) {
    this.columns.add(Column(name, type));
  }

  // Future<void> init() async => getConnection().initTable(table, columns);

  // SelectQuery select() => SelectQuery(table, columns.map((c) => c.name));

  // Future<Result> insert(Map<String, dynamic> values) async =>
  //     getConnection().insert(table, values) as Future<Result<TClass>>;

  // UpdateQuery update() => UpdateQuery(table: table);
}
