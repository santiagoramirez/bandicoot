import 'dart:core' as Core;

import 'package:bandicoot_orm/src/core/entity.dart';

import 'package:bandicoot_orm/src/data_types/char.dart';
import 'package:bandicoot_orm/src/data_types/enum.dart';
import 'package:bandicoot_orm/src/data_types/foreign.dart';
import 'package:bandicoot_orm/src/data_types/primary.dart';
import 'package:bandicoot_orm/src/data_types/string.dart';
import 'package:bandicoot_orm/src/data_types/text.dart';
import 'package:bandicoot_orm/src/data_types/uuid.dart';

import 'package:bandicoot_orm/src/enums/sql_dialect.dart';

abstract class DataTypeInterface {
  const DataTypeInterface();

  Core.String toSqlBefore() => '';

  Core.String toSql(SQLDialect dialect) => '';

  Core.bool validate(Core.dynamic value) => true;
}

class DataType {
  static DataTypeInterface Primary([Core.String type = 'id']) =>
      PrimaryType(type);

  static DataTypeInterface Foreign(Entity entity, Core.String foreignKey,
          {type = ForeignType.DefaultType}) =>
      ForeignType(entity, foreignKey, type: type);

  static DataTypeInterface Enum(Core.List<Core.dynamic> values) =>
      EnumType(values);

  static DataTypeInterface String(
          [Core.int? length = StringType.DefaultLength]) =>
      StringType(length);

  static DataTypeInterface Char([Core.int? length = CharType.DefaultLength]) =>
      CharType(length);

  static DataTypeInterface Text([Core.String? type]) => TextType(type);

  static DataTypeInterface UUID() => UUIDType();
}
