import 'package:bandicoot_orm/bandicoot_orm.dart';
import 'package:bandicoot_orm/src/connection.dart';
import 'package:bandicoot_orm/src/entity.dart';

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

abstract class Where {
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

abstract class Limit {
  int? _limit;
  int? _offset;

  int? get limit => _limit;
  void set limit(int? limit) => _limit = limit;

  int? get offset => _offset;
  void set offset(int? offset) => _offset = offset;
}

abstract class Order {
  String? _orderBy;
  String? _order;

  String? get orderBy => _orderBy;
  void set orderBy(String? orderBy) => _orderBy = orderBy;

  String? get order => _order;
  void set order(String? order) => _order = order;
}

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

class Query<TClass> {
  Serializer<TClass> serializer;
  String instance;

  late String _table;

  Query(this.serializer, [this.instance = BandicootORM.defaultInstance]);

  void table(String table) => _table = table;
  String getTable() => _table;

  Future<QueryResult<TClass>> execute() async {
    throw UnimplementedError();
  }
}

class FindQuery<TClass> extends Query<TClass> with Where, Limit, Order {
  late List<String> columns;

  FindQuery(Serializer<TClass> serializer,
      [String instance = BandicootORM.defaultInstance])
      : super(serializer, instance);

  @override
  execute() async {
    return await getConnection(instance).find(this);
  }
}

class InsertQuery<TClass> extends Query<TClass> {
  late Map<String, dynamic> _values;

  InsertQuery(Serializer<TClass> serializer) : super(serializer);

  Map<String, dynamic> get values => _values;
  void set values(Map<String, dynamic> values) => _values = values;

  @override
  execute() async {
    return await getConnection(instance).insert(this);
  }
}

class UpdateQuery<TClass> extends Query<TClass> with Where {
  late Map<String, dynamic> _values;

  UpdateQuery(Serializer<TClass> serializer) : super(serializer);

  Map<String, dynamic> get values => _values;
  void set values(Map<String, dynamic> values) => _values = values;

  @override
  execute() async {
    return await getConnection(instance).update(this, serializer);
  }
}

class DeleteQuery<TClass> extends Query<TClass> with Where {
  DeleteQuery(Serializer<TClass> serializer) : super(serializer);

  @override
  execute() async {
    return await getConnection(instance).delete(this);
  }
}
