import 'package:coach_app/core/network/api_endpoints.dart';
import 'package:coach_app/core/storage/auth_tokens.dart';
import 'package:dio/dio.dart';

/// Uses its own [Dio] instance (no auth interceptor) so a failing refresh
/// can never trigger another refresh.
class TokenRefreshClient {
  const TokenRefreshClient(this._dio);

  final Dio _dio;

  /// Returns `null` when the refresh token is rejected or the call fails.
  Future<AuthTokens?> refresh(String refreshToken) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );
      final body = response.data;
      final accessToken = body?['access_token'] as String?;
      final newRefreshToken = body?['refresh_token'] as String?;
      if (accessToken == null) return null;
      return AuthTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken ?? refreshToken,
      );
    } on DioException {
      return null;
    }
  }
}
