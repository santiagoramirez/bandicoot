import 'package:bandicoot_orm/src/connection/connection_manager.dart';
import 'package:bandicoot_orm/src/core/entity.dart';

export 'src/api/column.dart';
export 'src/core/data_type.dart';
export 'src/core/entity.dart';

class BandicootORM<T extends dynamic> {
  List<Entity> entities;
  late ConnectionManager<T> connectionManager;

  BandicootORM(
      {required String language,
      required T connection,
      required this.entities}) {
    connectionManager = ConnectionManager<T>(language, connection);
  }

  Future<void> connect() async {
    await connectionManager.connect();

    for (Entity entity in entities) {
      // await entity.init();
    }
  }
}
