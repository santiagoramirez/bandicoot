import 'package:bandicoot_orm/src/data_type.dart';
import 'package:bandicoot_orm/src/data_types/primary.dart';

const _primaryType = PrimaryType();

// Class for storing column metadata
class Column {
  /// The name of the [Column] in the table
  final String name;

  /// The data type of the [Column].
  final DataTypeInterface type;

  /// If true, allows null values in [Column]
  final bool nullable;

  /// If true, makes [Column] an index
  final bool index;

  /// If true, makes [Column] unique
  final bool unique;

  const Column(this.name, this.type,
      {this.nullable = false, this.index = false, this.unique = false});
}

class PrimaryColumn extends Column {
  const PrimaryColumn(String name) : super(name, _primaryType);
}
