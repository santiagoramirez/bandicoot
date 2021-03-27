import 'package:bandicoot_orm/src/query/query.dart';
import 'package:bandicoot_orm/src/query_builders/query_builder.dart';

typedef String Substituter(String key, [bool prepend]);
typedef Map<String, dynamic> SubstitutionValuesGetter<T>(T? value);
typedef Map<String, dynamic> ExtractMap<T>(T value);

Substituter createSubstiturer(
        [String prependValue = '', String appendValue = '']) =>
    (String key, [bool prepend = true]) =>
        '${prepend ? prependValue : ''}${key}${appendValue}';

SubstitutionValuesGetter<T> createSubstitutionValuesGetter<T>(
        Substituter substituter, ExtractMap<T> extract) =>
    (value) {
      if (value == null) {
        return {};
      }

      return (extract(value)).entries.fold<Map<String, dynamic>>(
          {},
          (previous, entry) => previous
            ..addEntries(
                [MapEntry(substituter(entry.key, false), entry.value)]));
    };

Substituter getInsertSubstitution = createSubstiturer('@', 'Insert');
Substituter getConditionSubstitution = createSubstiturer('@', 'Condition');

SubstitutionValuesGetter<Map<String, dynamic>> getInsertSubstitutionValues =
    createSubstitutionValuesGetter(getInsertSubstitution, (values) => values);

SubstitutionValuesGetter<List<Condition>> getConditionsSubstitutionValues =
    createSubstitutionValuesGetter(
        getConditionSubstitution,
        (condititions) => condititions.fold(
            {},
            (previousValue, condition) => previousValue
              ..addEntries([MapEntry(condition.column, condition.value)])));

class SQLQueryBuilder implements QueryBuilder {
  static Map<String, dynamic> getSubstitutionMap(
          {Map<String, dynamic>? values, List<Condition>? conditions}) =>
      {}
        ..addAll(getInsertSubstitutionValues(values))
        ..addAll(getConditionsSubstitutionValues(conditions));

  /// Build WHERE statement from [Where] class instance.
  static String buildWhere(List<Condition> conditions) {
    String whereString = conditions
        .map(
          (c) =>
              '${c.column} ${c.operator} ${getConditionSubstitution(c.column)}',
        )
        .join(' AND ');

    return whereString != '' ? 'WHERE $whereString' : '';
  }

  @override
  buildFindQuery<TClass>(query) {
    String columnsString =
        query.columns.length > 0 ? query.columns.join(', ') : '*';

    return PreparedQuery(
        'SELECT $columnsString FROM ${query.table} ${buildWhere(query.conditions)};',
        getSubstitutionMap(conditions: query.conditions));
  }

  @override
  buildInsertQuery<TClass>(query) {
    String table = query.getTable();
    Map<String, dynamic> values = query.getValues();

    String columnsString = '(${values.entries.map((e) => e.key).join(', ')})';

    String valuesString =
        ' (${values.entries.map((e) => getInsertSubstitution(e.key)).join(', ')})';

    return PreparedQuery(
        'INSERT INTO $table $columnsString VALUES ${valuesString};',
        getSubstitutionMap(values: values));
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
