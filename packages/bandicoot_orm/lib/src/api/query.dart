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
