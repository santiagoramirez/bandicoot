import 'package:bandicoot_orm/src/query.dart';
import 'package:bandicoot_orm/src/query_substitution.dart';

class PostgresSubstitution extends QuerySubstitution<Map<String, dynamic>> {
  String prependToSubstitution = '@';
  String appendToConditionSubstitution = 'Where';
  String appendToInsertSubstitution = 'Insert';

  Map<String, dynamic> _getInsertSubstitutionValues(
      Map<String, dynamic>? values) {
    if (values == null) {
      return {};
    }

    return values.entries.fold<Map<String, dynamic>>(
        {},
        (previous, entry) => previous
          ..addEntries(
              [MapEntry(getInsertSubstitution(entry.key), entry.value)]));
  }

  Map<String, dynamic> _getConditionsSubstitutionValues(
      List<Condition>? conditions) {
    if (conditions == null) {
      return {};
    }

    return conditions.fold(
        {},
        (previousValue, condition) => previousValue
          ..addEntries([
            MapEntry(
                getConditionSubstitution(condition.column), condition.value)
          ]));
  }

  @override
  getSubstitutionValues({values, conditions}) {
    return {}
      ..addAll(_getInsertSubstitutionValues(values))
      ..addAll(_getConditionsSubstitutionValues(conditions));
  }
}
