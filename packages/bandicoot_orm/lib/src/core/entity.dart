import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/core/data_type.dart';
import 'package:bandicoot_orm/src/query/query.dart';

abstract class Serializer<TClass> {
  TClass toClass(Map<String, dynamic> values);
  Map<String, dynamic> toTableRow(TClass model);
}

class Entity<TClass> {
  /// The database name of the table.
  String table;

  /// Column definitions of the columns that should be created.
  List<Column> columns = [];

  /// Serializer for converting table rows into models and vice versa.
  Serializer<TClass> serializer;

  Entity({required this.table, required this.serializer});

  /// Adds a new column to the entity.
  ///
  /// [name] - The database name of the column.
  /// [type] - The database type of the column.
  /// [unique] - Should this be created as a unique column.
  void column(
      {required String name, required DataTypeInterface type, bool? unique}) {
    this.columns.add(Column(name, type));
  }

  /// Returns a new [FindQuery] to finding resources.
  FindQuery<TClass> find() => FindQuery(serializer);

  /// Returns a new [InsertQuery] to inserting resources.
  InsertQuery<TClass> insert() => InsertQuery(serializer);

  /// Returns a new [UpdateQuery] for updating resources.
  UpdateQuery<TClass> update() => UpdateQuery(serializer);

  /// Returns a new [DeleteQuery] for deleting resources.
  DeleteQuery<TClass> delete() => DeleteQuery(serializer);
}
