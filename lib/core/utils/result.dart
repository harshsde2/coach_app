import 'package:coach_app/core/error/failure.dart';

/// The outcome of an operation that can fail in an expected way.
///
/// Repositories return a [Result] instead of throwing, so callers are forced
/// by the type system to handle the failure path:
///
/// ```dart
/// switch (await repository.login(...)) {
///   case Ok(:final value): ...
///   case Err(:final failure): ...
/// }
/// ```
sealed class Result<T> {
  const Result();
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
