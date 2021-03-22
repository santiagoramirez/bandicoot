import 'model.dart';
import 'orm.dart';
import 'query.dart';
import 'result.dart';

class SelectQuery<TModel extends Model> with Where, Limit, Order {
  /// Name of the current table we are selecting from.
  String table;

  /// List of all columns allowed to be selected.
  Iterable<String> columnsAllowed = [];

  /// List of columns to be selected.
  List<String> columnsSelected = [];

  SelectQuery(this.table, this.columnsAllowed);

  void columns(List<String> columns) {
    this.columnsSelected = columns;
  }

  Future<Result<TModel>> execute() async {
    return (await getConnection().select(
      table,
      columnsSelected,
      // where: this,
    )) as Result<TModel>;
  }
}
