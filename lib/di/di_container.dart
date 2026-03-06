import 'package:auth/config/config.dart';
import 'package:auth/database/database.dart';
import 'package:auth/logger/logger.dart';
import 'package:auth/service/crypto_service.dart';
import 'package:auth/service/hash_service.dart';
import 'package:auth/service/jwt_service.dart';

final class DiContainer {
  DiContainer({required this.logger});

  final AppLogger logger;

  late final Config config;
  late final AppDatabase database;
  late final HashService hashService;
  late final CryptoService cryptoService;
  late final JwtService jwtService;

  Future<void> load() async {
    logger.info('Загрузка DI контейнера...');
    try {
      config = Config(logger: logger);
      await config.load();
      logger.isStage = config.isStage;
      config.ShowConfig();
      database = AppDatabase(this);
      hashService = HashService(config: config);
      cryptoService = CryptoService(config: config);
      jwtService = JwtService(di: this);
      await AppDatabase.hasDbConnection(this);
    } on Object catch (error, stackTrace) {
      logger.error('Ошибка загрузки DI контейнера', error, stackTrace);
      rethrow;
    }
  }
}
