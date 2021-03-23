import 'package:bandicoot_orm/src/api/entity.dart';
import 'package:bandicoot_orm/src/connection/connection_manager.dart';

ConnectionManager? _connection;

ConnectionManager getConnection() {
  if (_connection == null) {
    throw 'Connection not established';
  }
  return _connection!;
}

class ORM<T> {
  List<Entity> entities;

  ORM(
      {required String language,
      required T connection,
      required this.entities}) {
    _connection = ConnectionManager(language, connection);
  }

  Future<void> connect() async {
    await getConnection().connect();

    for (Entity entity in entities) {
      await entity.init();
    }
  }
}
