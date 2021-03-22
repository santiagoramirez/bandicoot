import 'package:bandicoot_orm/src/core/data_type.dart';

class _Type {
  static const ID = 'id';
  static const UUID = 'uuid';
}

class PrimaryType extends DataTypeInterface {
  /// allows "id" or "uuid"
  final String _type;

  const PrimaryType([this._type = _Type.ID]);

  @override
  String toSql() {
    switch (_type) {
      case _Type.ID:
        return 'SERIAL PRIMARY KEY';
      case _Type.UUID:
        return 'PRIMARY KEY UUID';
      default:
        throw 'Unsupported type of "${_type}"';
    }
  }
}
