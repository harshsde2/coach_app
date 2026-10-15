import 'package:coach_app/core/error/failure.dart';
import 'package:dio/dio.dart';

/// Translates transport-level [DioException]s into domain [Failure]s.
///
// TODO(team): align `message` / `errors` keys with the fibodo API error
// format once the API docs are available.
abstract final class ApiErrorMapper {
  static Failure fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        return _fromResponse(exception.response);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return UnknownFailure(exception.message);
    }
  }

  static Failure _fromResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    final body = data is Map<String, dynamic>
        ? data
        : const <String, dynamic>{};
    final message = body['message'] as String?;

    return switch (statusCode) {
      401 || 403 => UnauthorizedFailure(message),
      400 || 409 || 422 => ValidationFailure(message, _fieldErrors(body)),
      final int code when code >= 500 => ServerFailure(message, code),
      _ => UnknownFailure(message),
    };
  }

  static Map<String, String> _fieldErrors(Map<String, dynamic> body) {
    final errors = body['errors'];
    if (errors is! Map<String, dynamic>) return const {};
    return errors.map(
      (field, value) => MapEntry(
        field,
        value is List && value.isNotEmpty ? '${value.first}' : '$value',
      ),
    );
  }
}
