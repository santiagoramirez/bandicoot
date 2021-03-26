import 'package:bandicoot_orm/src/query/query.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

// class SQLSubstitutionBuilder {
//   Map<String, dynamic>? values;
//   Where? where;

//   SQLSubstitutionBuilder({this.values, this.where});

//   String getValue(String key) => '@${key}Value';
//   String getWhere(String key) => '@${key}Where';

//   Map<String, dynamic> getMap() =>
//       {}..addAll(getValuesMap())..addAll(getWhereMap());

//   Map<String, dynamic> getValuesMap() =>
//       (values?.entries ?? []).fold<Map<String, dynamic>>(
//           {},
//           (previous, entry) => previous
//             ..addEntries([MapEntry(getValue(entry.key), entry.value)]));

//   Map<String, dynamic> getWhereMap() =>
//       (where?.conditions ?? []).fold<Map<String, dynamic>>(
//           {},
//           (previous, condition) => previous
//             ..addEntries(
//                 [MapEntry(getWhere(condition.column), condition.value)]));
// }

class SQLQueryBuilder implements QueryBuilder {
  /// Build WHERE statement from [Where] class instance.
  static String buildWhere(Where where) {
    // SQLSubstitutionBuilder substitution = SQLSubstitutionBuilder();
    dynamic substitution = '';

    String whereString = where.conditions
        .map(
          (c) => '${c.column} ${c.operator} ${substitution.getWhere(c.column)}',
        )
        .join(' AND ');

    return whereString != '' ? 'WHERE $whereString' : '';
  }

  @override
  buildFindQuery<TClass>(query) {
    // String table;
    // List<dynamic>? columns;
    // Where where;

    // SQLSelectBuilder(this.table, this.columns, this.where);

    // String getSelectColumns() => columns != null ? columns!.join(', ') : '*';

    // String toString() =>
    //     'SELECT ${getSelectColumns()} FROM $table ${getWhere()};';

    // SQLQuery toSqlQuery() => SQLQuery(toString(), substitution.getMap());

    return PreparedQuery('');
  }

  @override
  buildInsertQuery<TClass>(query) {
    // substitution = SQLSubstitutionBuilder(values: values);
    dynamic substitution = {};

    String table = query.getTable();
    Map<String, dynamic> values = query.getValues();

    String columnsString = '(${values.entries.map((e) => e.key).join(', ')})';

    String valuesString =
        ' (${values.entries.map((e) => substitution.getValue(e.key)).join(', ')})';

    return PreparedQuery(
        'INSERT INTO $table $columnsString VALUES ${valuesString};',
        substitution.getMap());
  }

  @override
  buildUpdateQuery<TClass>(query) {
    // String table;
    // Map<String, dynamic> values;
    // Where where;

    // SQLUpdateBuilder(this.table, this.values, this.where);

    // String toString() => 'UPDATE $table ${getSet()} ${getWhere()}};';

    // String getSet() {
    //   String setString = values.entries
    //       .map(
    //           (entry) => ('${entry.key} = ${substitution.getValue(entry.key)}'))
    //       .join(', ');

    //   return values.entries.length > 0 ? 'SET $setString' : '';
    // }

    // SQLQuery toSqlQuery() => SQLQuery(toString(), substitution.getMap());
    return PreparedQuery('');
  }

  @override
  buildDeleteQuery<TClass>(query) {
    return PreparedQuery('');
  }
}
