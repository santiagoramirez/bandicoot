class Columns {
  Columns();

  add(String name, dynamic type) {}
}

class Relations {
  addOneToOne(String name, entity) {}
  addOneToMany(String name, entity) {}
}

abstract class Entity2Interface<TModel> {
  void init(String language);
  TModel toModel(Map<String, dynamic> row);
  Map<String, dynamic> toRow(TModel model);
}

abstract class Entity2<TModel> implements Entity2Interface<TModel> {
  String table = '';
  Columns columns = Columns();
  Relations relations = Relations();

  toModel(row) {
    throw UnimplementedError();
  }

  toRow(model) {
    throw UnimplementedError();
  }
}
