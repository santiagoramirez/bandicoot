enum SQLDialect { Postgres }

abstract class SQLDialectConst {
  static const Postgres = 'postgres';

  static const _UnsupportedDialectError = 'Unsupported SQL dialect';

  SQLDialect toEnum(String dialectString) {
    switch (dialectString) {
      case Postgres:
        return SQLDialect.Postgres;
    }

    throw _UnsupportedDialectError;
  }
}
