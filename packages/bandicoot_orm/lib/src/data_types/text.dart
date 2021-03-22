import 'package:bandicoot_orm/src/core/data_type.dart';

class _Type {
  static const Tiny = 'tiny';
  static const Medium = 'medium';
  static const Long = 'long';
}

class TextType extends DataTypeInterface {
  final String? _type;

  const TextType([this._type]);

  @override
  String toSql() {
    switch (_type?.toLowerCase()) {
      case _Type.Tiny:
        return 'TINYTEXT';
      case _Type.Medium:
        return 'MEDIUMTEXT';
      case _Type.Long:
        return 'LONGTEXT';
      default:
        return 'TEXT';
    }
  }
}
