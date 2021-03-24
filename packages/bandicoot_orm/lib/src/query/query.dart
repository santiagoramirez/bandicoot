import 'package:bandicoot_orm/src/core/entity.dart';

class Operator {
  static const Eq = '=';

  static const Gt = '>';
  static const GtEq = '>=';

  static const Lt = '<';
  static const LtEq = '<';
}

class Condition {
  String column;
  dynamic value;
  String operator;

  Condition(this.column, this.value, this.operator);
}

class Where {
  List<Condition> conditions = [];

  void where(String column,
      {dynamic? equals, dynamic? greaterThan, dynamic? lessThan}) {
    if (equals != null) {
      conditions.add(Condition(column, equals, Operator.Eq));
    } else if (greaterThan != null) {
      conditions.add(Condition(column, greaterThan, Operator.Gt));
    } else if (lessThan) {
      conditions.add(Condition(column, lessThan, Operator.Lt));
    }
  }
}

class Limit {
  int? _limit;
  int? _offset;

  limit(int limit) => _limit = limit;
  offset(int offset) => _offset = offset;
}

class Order {
  String? _orderBy;
  String? _order;

  orderBy(String orderBy, String? order) {
    _orderBy = orderBy;
    _order = order;
  }
}

class Query<TClass> {
  Serializer<TClass> serializer;

  Query(this.serializer);
}

class FindQuery<TClass> extends Query<TClass> {
  Serializer<TClass> serializer;

  FindQuery(this.serializer) : super(serializer);
}

// class SelectQuery<TClass> with Where, Limit, Order {
//   /// Name of the current table we are selecting from.
//   String table;

//   /// List of all columns allowed to be selected.
//   Iterable<String> columnsAllowed = [];

//   /// List of columns to be selected.
//   List<String> columnsSelected = [];

//   ConnectionManager connection;

//   SelectQuery(this.table, this.columnsAllowed, this.connection);

//   void columns(List<String> columns) {
//     this.columnsSelected = columns;
//   }

//   Future<QueryResult<TClass>> execute() async {
//     QueryResult<TClass> result = await connection.select<TClass>(
//       table,
//       columnsSelected,
//       // where: this,
//     );

//     return result;
//   }
// }

class InsertQuery<TClass> extends Query<TClass> {
  Serializer<TClass> serializer;

  InsertQuery(this.serializer) : super(serializer);
}

class UpdateQuery<TClass> extends Query<TClass> {
  Serializer<TClass> serializer;

  UpdateQuery(this.serializer) : super(serializer);
}

// class UpdateQuery with Where {
//   late String _table;
//   Map<String, dynamic> _values = {};

//   UpdateQuery({required table, connectionManager}) {
//     this._table = table;
//   }

//   /// Set a map of data to be updated.
//   data(Map<String, dynamic> values) {
//     _values = values;
//   }

//   Future<dynamic> execute() async {
//     await getConnection().update(_table, _values, this);
//   }
// }

class DeleteQuery<TClass> extends Query<TClass> {
  Serializer<TClass> serializer;

  DeleteQuery(this.serializer) : super(serializer);
}