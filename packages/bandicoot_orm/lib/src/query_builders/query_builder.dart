import 'package:bandicoot_orm/src/query/query.dart';

class PreparedQuery {
  String query;
  Map<String, dynamic>? substitutionValues;

  PreparedQuery(this.query, [this.substitutionValues]);
}

abstract class QueryBuilder {
  PreparedQuery buildSearchQuery(FindQuery query);
  PreparedQuery buildInsertQuery(InsertQuery query);
  PreparedQuery buildUpdateQuery(UpdateQuery query);
  PreparedQuery buildDeleteQuery(DeleteQuery query);
}
