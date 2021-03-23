import 'package:bandicoot_orm/src/api/column.dart';
import 'package:bandicoot_orm/src/api/query.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';
import 'package:bandicoot_orm/src/utils/sql_builder.dart';

class SQLCreateTableBuilder {
  String table;
  List<Column> columns;

  SQLCreateTableBuilder(this.table, this.columns);

  String toString() =>
      'CREATE TABLE IF NOT EXISTS "$table" (${_createColumns})';

  String get _createColumns {
    List createColumns = [];

    for (Column column in columns) {
      List<String> createColumn = [
        '"${column.name}"',
        column.type.toSql(SQLDialect.Postgres)
      ];

      if (column.unique) createColumn.add('UNIQUE');
      if (column.index) createColumn.add('INDEX');
      if (!column.nullable) createColumn.add('NOT NULL');

      createColumns.add(createColumn.join(' '));
    }

    return createColumns.join(', ');
  }

  SQLQuery toSqlQuery() => SQLQuery(toString());
}

class SQLInsertBuilder {
  String table;
  Map<String, dynamic> values;

  late SQLSubstitutionBuilder substitution;

  SQLInsertBuilder(this.table, this.values) {
    substitution = SQLSubstitutionBuilder(values: values);
  }

  String _getColumns() => '(${values.entries.map((e) => e.key).join(', ')})';

  String _getValues() =>
      'VALUES (${values.entries.map((e) => substitution.getValue(e.key)).join(', ')})';

  String toString() => 'INSERT INTO $table ${_getColumns()} ${_getValues()};';

  SQLQuery toSqlQuery() => SQLQuery(toString(), substitution.getMap());
}

class SQLSelectBuilder with SQLWhereBuilder {
  String table;
  List<dynamic>? columns;
  Where where;

  SQLSelectBuilder(this.table, this.columns, this.where);

  String getSelectColumns() => columns != null ? columns!.join(', ') : '*';

  String toString() =>
      'SELECT ${getSelectColumns()} FROM $table ${getWhere()};';

  SQLQuery toSqlQuery() => SQLQuery(toString(), substitution.getMap());
}

class SQLSubstitutionBuilder {
  Map<String, dynamic>? values;
  Where? where;

  SQLSubstitutionBuilder({this.values, this.where});

  String getValue(String key) => '@${key}Value';
  String getWhere(String key) => '@${key}Where';

  Map<String, dynamic> getMap() =>
      {}..addAll(getValuesMap())..addAll(getWhereMap());

  Map<String, dynamic> getValuesMap() =>
      (values?.entries ?? []).fold<Map<String, dynamic>>(
          {},
          (previous, entry) => previous
            ..addEntries([MapEntry(getValue(entry.key), entry.value)]));

  Map<String, dynamic> getWhereMap() =>
      (where?.conditions ?? []).fold<Map<String, dynamic>>(
          {},
          (previous, condition) => previous
            ..addEntries(
                [MapEntry(getWhere(condition.column), condition.value)]));
}

class SQLUpdateBuilder with SQLWhereBuilder {
  String table;
  Map<String, dynamic> values;
  Where where;

  SQLUpdateBuilder(this.table, this.values, this.where);

  String toString() => 'UPDATE $table ${getSet()} ${getWhere()}};';

  String getSet() {
    String setString = values.entries
        .map((entry) => ('${entry.key} = ${substitution.getValue(entry.key)}'))
        .join(', ');

    return values.entries.length > 0 ? 'SET $setString' : '';
  }

  SQLQuery toSqlQuery() => SQLQuery(toString(), substitution.getMap());
}

class SQLWhereBuilder {
  late Where where;
  SQLSubstitutionBuilder substitution = SQLSubstitutionBuilder();

  String getConditionString(Condition condition) =>
      '${condition.column} ${condition.operator} ${substitution.getWhere(condition.column)}';

  String getWhere() {
    String whereString = where.conditions.map(getConditionString).join(' AND ');
    return whereString != '' ? 'WHERE $whereString' : '';
  }
}
