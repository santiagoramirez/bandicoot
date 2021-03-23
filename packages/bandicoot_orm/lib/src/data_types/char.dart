import 'package:bandicoot_orm/src/core/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class CharType extends DataTypeInterface {
  final int? length;

  static const DefaultLength = 255;

  const CharType([this.length = DefaultLength]);

  String toSql(SQLDialect dialect) => 'CHAR($length)';
}
