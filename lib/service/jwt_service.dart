import 'package:auth/di/di_container.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtService {
  JwtService({required this.di});

  final DiContainer di;

  (String, String) createTokens(int userId) {
    final accessToken = _createToken(userId, di.config.jwtAccessExp);
    final refreshToken = _createToken(userId, di.config.jwtRefreshExp);
    di.logger.debug(
      'Tokens created for userId: $userId - AccessToken: $accessToken, RefreshToken: $refreshToken',
    );
    return (accessToken, refreshToken);
  }

  String _createToken(int userId, int exp) {
    final jwt = JWT({
      'userId': userId,
      'exp': exp,
      'iat': DateTime.now().toUtc().toIso8601String(),
    });
    final token = jwt.sign(
      SecretKey(di.config.jwtSecret),
      expiresIn: Duration(seconds: exp),
    );
    di.logger.debug(
      'Token created: $token for userId: $userId with exp: $exp seconds',
    );
    return token;
  }

  Map<String, dynamic>? verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(di.config.jwtSecret));
      final payload = jwt.payload as Map<String, dynamic>;
      return payload;
    } catch (e) {
      di.logger.error('Token verification failed: $e', e, StackTrace.current);
      return null;
    }
  }
}
