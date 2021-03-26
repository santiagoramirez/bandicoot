import 'package:bandicoot_orm/src/data_type.dart';
import 'package:bandicoot_orm/src/entity.dart';
import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

class ForeignType extends DataTypeInterface {
  final Entity entity;
  final String foreignKey;
  final String type;

  static const DefaultType = 'integer';

  const ForeignType(this.entity, this.foreignKey, {this.type = DefaultType});

  @override
  String toSql(SQLDialect dialect) {
    return '$type REFERENCES "${entity.table}" ("$foreignKey")';
  }
}
