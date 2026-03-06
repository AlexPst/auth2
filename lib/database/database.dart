import 'package:auth/database/models/user.dart';
import 'package:auth/di/di_container.dart';
import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart' as pg;

part 'database.g.dart';

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase(DiContainer di, [QueryExecutor? executor])
    : super(executor ?? _openConnection(di));

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection(DiContainer di) {
    final connectionSettings = pg.ConnectionSettings(
      sslMode: pg.SslMode.disable,
    );
    final database = PgDatabase(
      endpoint: pg.Endpoint(
        host: di.config.dbHost,
        port: di.config.dbPort,
        database: di.config.dbName,
        username: di.config.dbUser,
        password: di.config.dbPassword,
      ),
      settings: connectionSettings,
    );
    di.logger.info('Успешно подключились к базе данных');
    return database;
  }

  static Future<bool> hasDbConnection(DiContainer di) async {
    try {
      await di.database.customSelect('SELECT 1').getSingle();
      di.logger.info('Проверка подключения к базе данных прошла успешно');
      return true;
    } catch (e, st) {
      di.logger.error('Ошибка подключения к базе данных', e, st);
      return false;
    }
  }
}
