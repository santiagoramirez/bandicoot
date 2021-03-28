import 'package:bandicoot_orm/src/query.dart';

typedef String Substituter(String key, [bool prepend]);
typedef Map<String, dynamic> SubstitutionValuesGetter<T>(T? value);
typedef Map<String, dynamic> ExtractMap<T>(T value);

class QuerySubstitution<TSubstitutionValues> {
  String prependToSubstitution = '';
  String appendToConditionSubstitution = '';
  String appendToInsertSubstitution = '';

  String getSubstitution(
    String key, {
    bool prepend = true,
    String appendValue = '',
  }) =>
      '${prepend ? prependToSubstitution : ''}${key}${appendValue}';

  String getInsertSubstitution(String key) =>
      getSubstitution(key, appendValue: appendToInsertSubstitution);

  String getConditionSubstitution(String key) =>
      getSubstitution(key, appendValue: appendToConditionSubstitution);

  TSubstitutionValues getSubstitutionValues(
      {Map<String, dynamic>? values, List<Condition>? conditions}) {
    throw UnimplementedError();
  }
}
