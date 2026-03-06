import 'dart:io';

import 'package:auth/di/di_container.dart';
import 'package:auth/handlers/app_handlers.dart';
import 'package:auth/logger/logger.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  final logger = AppLogger()..info('Сервер запущен');

  final diContainer = DiContainer(logger: logger);
  await diContainer.load();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final appHandler = AppHandler(di: diContainer);
  final server = await serve(appHandler.handler, ip, diContainer.config.port);

  logger.info('Сервер запущен на порту ${server.port}');
}
