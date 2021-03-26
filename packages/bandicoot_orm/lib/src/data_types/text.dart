import 'package:bandicoot_orm/src/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class TextType extends DataTypeInterface {
  final String? type;

  static const Tiny = 'tiny';
  static const Medium = 'medium';
  static const Long = 'long';

  const TextType([this.type]);

  String get lowerType => type?.toLowerCase() ?? '';

  @override
  String toSql(SQLDialect dialect) {
    switch (lowerType) {
      case Tiny:
        return 'TINYTEXT';
      case Medium:
        return 'MEDIUMTEXT';
      case Long:
        return 'LONGTEXT';
      default:
        return 'TEXT';
    }
  }
}
