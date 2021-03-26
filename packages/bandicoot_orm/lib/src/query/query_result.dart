import 'package:bandicoot_orm/src/entity.dart';

class QueryRows<TClass> {
  List<Map<String, dynamic>> _rows = [];
  late Serializer<TClass>? _serializer;

  QueryRows(this._rows, [this._serializer]);

  Iterable<TClass> toClassList() {
    if (_serializer == null) {
      throw '';
    }

    return _rows.map((row) => _serializer!.toClass(row));
  }

  List<Map<String, dynamic>> toMapList() => _rows;
}

class QueryResult<TClass> {
  late QueryRows<TClass> rows;

  QueryResult(
      {required List<Map<String, dynamic>> rows,
      Serializer<TClass>? serializer}) {
    this.rows = QueryRows(rows, serializer);
  }
}
