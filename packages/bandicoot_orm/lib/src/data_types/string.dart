import 'package:bandicoot_orm/src/core/data_type.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class StringType extends DataTypeInterface {
  final int? _length;

  const StringType([this._length = 255]);

  @override
  String toSql(SQLDialect dialect) {
    return 'VARCHAR(${_length})';
  }
}
