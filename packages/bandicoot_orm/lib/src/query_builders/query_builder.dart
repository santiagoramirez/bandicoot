import 'package:bandicoot_orm/src/query.dart';
import 'package:bandicoot_orm/src/query_substitution.dart';

class PreparedQuery {
  String query;
  Map<String, dynamic>? substitutionValues;

  PreparedQuery(this.query, [this.substitutionValues]);
}

abstract class QueryBuilder<TQuerySubstitution extends QuerySubstitution> {
  late TQuerySubstitution substitution;

  PreparedQuery buildFindQuery<TClass>(FindQuery<TClass> query);
  PreparedQuery buildInsertQuery<TClass>(InsertQuery<TClass> query);
  PreparedQuery buildUpdateQuery<TClass>(UpdateQuery<TClass> query);
  PreparedQuery buildDeleteQuery<TClass>(DeleteQuery<TClass> query);
}
