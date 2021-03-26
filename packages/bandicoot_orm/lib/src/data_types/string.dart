import 'package:bandicoot_orm/src/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class StringType extends DataTypeInterface {
  final int? _length;

  static const DefaultLength = 255;

  const StringType([this._length = DefaultLength]);

  @override
  String toSql(SQLDialect dialect) {
    return 'VARCHAR(${_length})';
  }
}
