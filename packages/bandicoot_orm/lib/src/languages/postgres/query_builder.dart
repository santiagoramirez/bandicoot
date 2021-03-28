import 'package:bandicoot_orm/src/query.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

import './query_substitution.dart';

class PostgresQueryBuilder implements QueryBuilder<PostgresSubstitution> {
  late PostgresSubstitution substitution;

  /// Build WHERE statement from [Where] class instance.
  static String buildWhere(List<Condition> conditions) {
    String whereString = conditions
        .map((c) =>
            '${c.column} ${c.operator} ${substitution.getConditionSubstitution(c.column)}')
        .join(' AND ');

    return whereString != '' ? 'WHERE $whereString' : '';
  }

  @override
  buildFindQuery<TClass>(query) {
    String columnsString =
        query.columns.length > 0 ? query.columns.join(', ') : '*';

    return PreparedQuery(
        'SELECT $columnsString FROM ${query.table} ${buildWhere(query.conditions)};',
        substitution.getSubstitutionValues(conditions: query.conditions));
  }

  @override
  buildInsertQuery<TClass>(query) {
    String columnsString =
        '(${query.values.entries.map((e) => e.key).join(', ')})';

    String valuesString =
        ' (${query.values.entries.map((e) => substitution.getInsertSubstitution(e.key)).join(', ')})';

    return PreparedQuery(
        'INSERT INTO ${query.getTable()} $columnsString VALUES ${valuesString};',
        substitution.getSubstitutionValues(values: query.values));
  }

  @override
  buildUpdateQuery<TClass>(query) {
    String setStringd = query.values.entries
        .map((entry) =>
            ('${entry.key} = ${substitution.getInsertSubstitution(entry.key)}'))
        .join(', ');

    String setString = query.values.entries.length > 0 ? 'SET $setStringd' : '';

    return PreparedQuery(
        'UPDATE ${query.table} ${setString} ${buildWhere(query.conditions)};');
  }

  @override
  buildDeleteQuery<TClass>(query) {
    return PreparedQuery('');
  }
}
