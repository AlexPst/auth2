import 'dart:io';

const String _name = '[AUTH]';

final class AppLogger {
  bool _isStage = false;

  void info(String message) {
    stdout.writeln('${DateTime.now()}: $_name:[INFO] >$message');
  }

  void error(String message, Object error, StackTrace? stackTrace) {
    stderr.writeln(
      '${DateTime.now()}: $_name:[ERROR] >$message, error: $error, stackTrace: $stackTrace',
    );
  }

  void debug(String message) {
    if (_isStage) {
      stdout.writeln('${DateTime.now()}: $_name:[DEBUG] >$message');
    }
  }

  set isStage(bool isStage) => _isStage = isStage;
}
