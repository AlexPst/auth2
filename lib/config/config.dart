import 'dart:io';
import 'package:auth/logger/logger.dart';

final class Config {
  Config({required this.logger});

  final AppLogger logger;
  late final int port;
  late final bool isStage;
  late final String salt;
  late final String jwtSecret;
  late final int jwtAccessExp;
  late final int jwtRefreshExp;

  late final String dbHost;
  late final String dbName;
  late final String dbUser;
  late final String dbPassword;
  late final int dbPort;

  Future<void> load() async {
    logger.info('Загрузка конфигурации...');
    try {
      port = int.parse(_getEnv('PORT'));
      isStage = _getEnv('IS_STAGE') == 'true';
      dbHost = _getEnv('DB_HOST');
      dbName = _getEnv('DB_NAME');
      dbUser = _getEnv('DB_USER');
      dbPassword = _getEnv('DB_PASSWORD');
      dbPort = int.parse(_getEnv('DB_PORT'));
      salt = _getEnv('SALT');
      jwtSecret = _getEnv('JWT_SECRET');
      jwtAccessExp = int.parse(_getEnv('JWT_ACCESS_EXP'));
      jwtRefreshExp = int.parse(_getEnv('JWT_REFRESH_EXP'));
    } catch (e) {
      logger.error('Ошибка загрузки конфигурации', e, StackTrace.current);
      throw Exception('Ошибка загрузки конфигурации: $e');
    }
  }

  String _getEnv(String name) {
    final value = Platform.environment[name];
    if (value == null) {
      throw Exception('Переменная окружения $name не найдена');
    }
    return value;
  }

  void ShowConfig() {
    logger
      ..debug('Текущая конфигурация:')
      ..debug('Порт: $port')
      ..debug('Статус: $isStage')
      ..debug('DB Host: $dbHost')
      ..debug('DB Name: $dbName')
      ..debug('DB User: $dbUser')
      ..debug('DB Password: $dbPassword')
      ..debug('DB Port: $dbPort')
      ..debug('Salt: $salt')
      ..debug('JWT Secret: $jwtSecret')
      ..debug('JWT Access Exp: $jwtAccessExp')
      ..debug('JWT Refresh Exp: $jwtRefreshExp');
  }
}
