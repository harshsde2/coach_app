import 'package:coach_app/core/network/token_refresh_client.dart';
import 'package:coach_app/core/storage/auth_tokens.dart';
import 'package:coach_app/core/storage/token_storage.dart';
import 'package:dio/dio.dart';

/// A [QueuedInterceptor] processes errors one at a time, so when several
/// requests fail together only the first performs the refresh; the others
/// see that the stored token changed and simply retry with it.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required this._tokenStorage,
    required this._refreshClient,
    required this._retryClient,
    required this._onSessionExpired,
  });

  /// Set `Options(extra: {AuthInterceptor.skipAuth: true})` for public
  /// endpoints such as login.
  static const skipAuth = 'skipAuth';
  static const _retried = 'authRetried';

  final TokenStorage _tokenStorage;
  final TokenRefreshClient _refreshClient;
  final Dio _retryClient;
  final void Function() _onSessionExpired;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[skipAuth] != true) {
      final tokens = await _tokenStorage.read();
      if (tokens != null) _authorize(options, tokens.accessToken);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final shouldRefresh =
        err.response?.statusCode == 401 &&
        options.extra[skipAuth] != true &&
        options.extra[_retried] != true;
    if (!shouldRefresh) return handler.next(err);

    final stored = await _tokenStorage.read();
    if (stored == null) return handler.next(err);

    final tokens = _wasSentWith(options, stored)
        ? await _refresh(stored.refreshToken)
        : stored;

    if (tokens == null) {
      await _tokenStorage.clear();
      _onSessionExpired();
      return handler.next(err);
    }

    try {
      _authorize(options, tokens.accessToken);
      options.extra[_retried] = true;
      handler.resolve(await _retryClient.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<AuthTokens?> _refresh(String refreshToken) async {
    final tokens = await _refreshClient.refresh(refreshToken);
    if (tokens != null) await _tokenStorage.save(tokens);
    return tokens;
  }

  bool _wasSentWith(RequestOptions options, AuthTokens tokens) =>
      options.headers['Authorization'] == 'Bearer ${tokens.accessToken}';

  void _authorize(RequestOptions options, String accessToken) =>
      options.headers['Authorization'] = 'Bearer $accessToken';
}
