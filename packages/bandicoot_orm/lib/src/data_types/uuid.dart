import 'package:bandicoot_orm/src/core/data_type.dart';

class UUIDType implements DataTypeInterface {
  @override
  String toSql() {
    return 'UUID';
  }

  @override
  bool validate(dynamic value) => true;
}
