import 'package:bandicoot/src/interface/ValidationRule.dart';

Map _uuidRegex = {
  '3': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$'),
  '4': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  '5': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  'all': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$')
};

List<String> _versions = ['3', '4', '5', 'all'];

/// Check if a given string is a UUID.
///
/// Valid [version] types include '3', '4', '5' and 'all'
bool isUUID(String string, [String version = 'all']) =>
    _versions.contains(version.toString()) &&
    _uuidRegex[version.toString()].hasMatch(string.toUpperCase());

/// [ValidationRule] for [isUUID] validator
ValidationRule<String> IsUUID({String version = 'all', String? message}) =>
    ValidationRule(
        message: message,
        constraints: [version],
        validate: (value, arguments) =>
            Future(() => isUUID(value, arguments.constraints[0])),
        defaultMessage: (arguments) =>
            '"$arguments.property" must be a valid UUID');
