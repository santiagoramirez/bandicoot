import 'package:bandicoot_orm/src/connection/connection_interface.dart';
import 'package:bandicoot_orm/src/languages/postgres/connection.dart';

class _Language {
  static const Postgres = 'postgres';
}

/// Creates a consistent connection to any supported language.
class ConnectionManager<LanguageConnection extends dynamic>
    implements ConnectionInterface<dynamic> {
  String language;
  LanguageConnection languageConnection;

  late ConnectionInterface connection;

  ConnectionManager(this.language, this.languageConnection) {
    switch (language) {
      case _Language.Postgres:
        connection = PostgresConnection(languageConnection);
    }
  }

  connect() async => await this.connection.connect();

  initTable(table, columns) async => await connection.initTable(table, columns);

  query(query) async => await connection.query(query);

  select(table, columns) async => await connection.select(table, columns);

  insert(table, values) async => await connection.insert(table, values);

  update(table, values, where) async =>
      await connection.update(table, values, where);
}
