import 'package:bandicoot_orm/src/query/query.dart';

class PreparedQuery {
  String query;
  Map<String, dynamic>? substitutionValues;

  PreparedQuery(this.query, [this.substitutionValues]);
}

abstract class QueryBuilder {
  PreparedQuery buildFindQuery<TClass>(FindQuery<TClass> query);
  PreparedQuery buildInsertQuery<TClass>(InsertQuery<TClass> query);
  PreparedQuery buildUpdateQuery<TClass>(UpdateQuery<TClass> query);
  PreparedQuery buildDeleteQuery<TClass>(DeleteQuery<TClass> query);
}
