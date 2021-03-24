import 'package:bandicoot_orm/src/connection/connection.dart';
import 'package:bandicoot_orm/src/languages/postgres/connection.dart';

class _Language {
  static const Postgres = 'postgres';
}

/// Creates a consistent connection to any supported language.
class ConnectionManager<TLanguageConnection extends dynamic> {
  String language;
  TLanguageConnection languageConnection;

  late Connection connection;

  ConnectionManager(this.language, this.languageConnection) {
    switch (language) {
      case _Language.Postgres:
        connection = PostgresConnection(languageConnection);
    }
  }

  Future<void> connect() async {
    connection.connect();
  }
}
