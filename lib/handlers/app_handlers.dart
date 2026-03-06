import 'dart:convert';

import 'package:auth/database/database.dart';
import 'package:auth/di/di_container.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'health.dart';
part 'sign_up.dart';

final class AppHandler {
  AppHandler({required this.di});

  final DiContainer di;

  Handler get handler {
    final router = Router()
      ..get('/health', (request) => _heathHandler(request, di))
      ..post('/sign-up', (request) => _signUpHandler(request, di));
    return Pipeline().addMiddleware(logRequests()).addHandler(router.call);
  }
}
