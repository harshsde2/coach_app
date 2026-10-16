/// Implements [Exception] so data sources may also `throw` a failure
/// directly (e.g. mock data sources simulating server responses).
sealed class Failure implements Exception {
  const Failure([this.message]);

  /// Server-provided, user-presentable message, when available.
  final String? message;

  @override
  String toString() => 'Failure(${message ?? ''})';
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message]);
}

final class ValidationFailure extends Failure {
  const ValidationFailure([super.message, this.fieldErrors = const {}]);

  final Map<String, String> fieldErrors;
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message, this.statusCode]);

  final int? statusCode;
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}
