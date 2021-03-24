import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/core/entity_sync.dart';

export 'src/api/column.dart';
export 'src/core/data_type.dart';
export 'src/core/entity.dart';

class BandicootORM {
  late List<Entity> _entities;
  late Connection _connection;

  BandicootORM(
      {required String type,
      required dynamic connection,
      required List<Entity> entities}) {
    _entities = entities;
    _connection = createConnection(type, connection);
  }

  Future<void> connect() async {
    await _connection.connect();

    for (Entity entity in _entities) {
      await EntitySync.synchronize(entity, _connection);
    }
  }
}
