import 'package:bandicoot_orm/src/api/entity.dart';

enum RelationType { OneToOne, OneToMany }

/// Base class for creating relations.
class Relation {
  final String attrName;
  final Entity foreignEntity;
  final String localKey;
  final String foreignKey;
  final RelationType type;

  const Relation(this.attrName, this.foreignEntity, this.localKey,
      this.foreignKey, this.type);
}

class OneToOne extends Relation {
  const OneToOne(attrName, foreignEntity, localKey, foreignKey)
      : super(attrName, foreignEntity, localKey, foreignKey,
            RelationType.OneToOne);
}

class OneToMany extends Relation {
  const OneToMany(attrName, foreignEntity, localKey, foreignKey)
      : super(attrName, foreignEntity, localKey, foreignKey,
            RelationType.OneToMany);
}
