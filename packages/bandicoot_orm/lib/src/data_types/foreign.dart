import 'package:bandicoot_orm/src/api/entity.dart';
import 'package:bandicoot_orm/src/core/data_type.dart';

class ForeignType extends DataTypeInterface {
  final Entity entity;
  final String foreignKey;
  final String type;

  static const DefaultType = 'integer';

  const ForeignType(this.entity, this.foreignKey, {this.type = DefaultType});

  @override
  toSql() {
    return '$type REFERENCES "${entity.table}" ("$foreignKey")';
  }
}
