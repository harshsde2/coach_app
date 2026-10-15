/// A typed, expected error returned from the data layer.
///
/// Sealed so the presentation layer can `switch` over every case.
/// Implements [Exception] so data sources may also `throw` a failure
/// directly (e.g. mock data sources simulating server responses).
sealed class Failure implements Exception {
  const Failure([this.message]);

  /// Server-provided, user-presentable message, when available.
  final String? message;

  @override
  String toString() => 'Failure(${message ?? ''})';
}

/// No connection, DNS failure, or the request timed out.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

/// The session is missing, expired, or could not be refreshed.
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message]);
}

/// The request was understood but rejected (4xx with field errors).
final class ValidationFailure extends Failure {
  const ValidationFailure([super.message, this.fieldErrors = const {}]);

  /// Field name → error message, as returned by the API.
  final Map<String, String> fieldErrors;
}

/// The server failed to handle a valid request (5xx).
final class ServerFailure extends Failure {
  const ServerFailure([super.message, this.statusCode]);

  final int? statusCode;
}

/// Anything not anticipated. Logged; shown to users as a generic error.
final class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}
