import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/core/entity.dart';
import 'package:bandicoot_orm/src/core/entity_sync.dart';

export 'src/api/column.dart';
export 'src/core/data_type.dart';
export 'src/core/entity.dart';

class BandicootORM {
  static Map<String, Connection> connections = {};
  static const defaultInstance = 'default';

  late List<Entity> _entities;
  late Connection _connection;

  BandicootORM(
      {required String type,
      required dynamic connection,
      required List<Entity> entities,
      String? instance}) {
    _entities = entities;

    String instanceName = instance != null ? instance : defaultInstance;

    if (connections[instanceName] != null) {
      throw 'Connection instance named "$instanceName" already exists.';
    }

    _connection = createConnection(type, connection);
    connections[instanceName] = _connection;
  }

  Future<void> connect() async {
    await _connection.connect();

    for (Entity entity in _entities) {
      await EntitySync.synchronize(entity, _connection);
    }
  }
}
