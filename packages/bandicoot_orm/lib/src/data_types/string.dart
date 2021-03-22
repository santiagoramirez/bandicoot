import 'package:bandicoot_orm/src/core/data_type.dart';

class StringType extends DataTypeInterface {
  final int? _length;

  const StringType([this._length = 255]);

  @override
  String toSql() {
    return 'VARCHAR(${_length})';
  }
}
