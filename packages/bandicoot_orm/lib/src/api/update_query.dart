import 'package:bandicoot_orm/bandicoot_orm.dart';

import 'query.dart';

class UpdateQuery with Where {
  late String _table;
  Map<String, dynamic> _values = {};

  UpdateQuery({required table}) {
    this._table = table;
  }

  /// Set a map of data to be updated.
  data(Map<String, dynamic> values) {
    _values = values;
  }

  Future<dynamic> execute() async {
    await getConnection().update(_table, _values, this);
  }
}
