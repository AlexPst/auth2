part of 'app_handlers.dart';

Future<Response> _heathHandler(Request request, DiContainer di) async {
  try {
    final isDbConnectioned = await AppDatabase.hasDbConnection(di);
    if (!isDbConnectioned) {
      return Response(
        503,
        body: 'База данных недоступна',
        headers: {'Content-Type': 'application/json'},
      );
    }
    return Response.ok(
      'Сервер доступен, база данных доступна',
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(
      body: 'Ошибка проверки состояния сервера',
      headers: {'Content-Type': 'application/json'},
    );
  }
}
