import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

class PostgresQueryBuilder implements QueryBuilder {
  @override
  buildSearchQuery(findQuery) {
    return PreparedQuery('');
  }

  @override
  buildInsertQuery(insertQuery) {
    return PreparedQuery('');
  }

  @override
  buildUpdateQuery(updateQuery) {
    return PreparedQuery('');
  }

  @override
  buildDeleteQuery(deleteQuery) {
    return PreparedQuery('');
  }
}
