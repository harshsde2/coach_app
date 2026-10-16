import 'package:coach_app/core/logging/app_logger.dart';
import 'package:dio/dio.dart';

/// Logs method, URL and status only: bodies and headers can contain tokens
/// or personal data and are never written to the log.
class LoggingInterceptor extends Interceptor {
  static const _tag = 'HTTP';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('→ ${options.method} ${options.uri}', tag: _tag);
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final request = response.requestOptions;
    AppLogger.debug(
      '← ${response.statusCode} ${request.method} ${request.uri}',
      tag: _tag,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final request = err.requestOptions;
    AppLogger.debug(
      '✕ ${err.response?.statusCode ?? err.type.name} '
      '${request.method} ${request.uri}',
      tag: _tag,
    );
    handler.next(err);
  }
}
