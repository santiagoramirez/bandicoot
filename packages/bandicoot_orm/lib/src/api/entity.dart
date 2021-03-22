import 'package:bandicoot_orm/src/core/data_type.dart';

import 'column.dart';
import 'model.dart';
import 'orm.dart';
import 'result.dart';
import 'select_query.dart';
import 'update_query.dart';

abstract class EntityInterface {
  Future<void> init();
  SelectQuery select();
  Future<Result> insert(Map<String, dynamic> values);
  UpdateQuery update();
}

class Relation {
  const Relation();
}

class OneToOne extends Relation {
  const OneToOne(Entity entity, String foreignKey);
}

class OneToMany extends Relation {
  const OneToMany(Entity entity, String foreignKey);
}

class Entity<TModel extends Model> implements EntityInterface {
  String table;
  List<Column> columns = [];
  List<Relation> relations = [];

  Entity(this.table);

  column(
      {required String name, required DataTypeInterface type, bool? unique}) {
    this.columns.add(Column(name, type));
  }

  relation({required String name, required Entity entity}) {}

  init() async => getConnection().initTable(table, columns);

  select() => SelectQuery(table, columns.map((c) => c.name));

  insert(values) async =>
      getConnection().insert(table, values) as Future<Result<TModel>>;

  update() => UpdateQuery(table: table);
}
