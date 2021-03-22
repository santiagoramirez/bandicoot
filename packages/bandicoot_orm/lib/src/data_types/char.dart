import 'package:bandicoot_orm/src/core/data_type.dart';

class CharType extends DataTypeInterface {
  final int? length;

  static const DefaultLength = 255;

  const CharType([this.length = DefaultLength]);

  toSql() => 'CHAR($length)';
}
