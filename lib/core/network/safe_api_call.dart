import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/core/logging/app_logger.dart';
import 'package:coach_app/core/network/api_error_mapper.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:dio/dio.dart';

/// Runs [call] and converts every thrown error into an [Err].
///
/// The single place where exceptions become values: repositories wrap
/// their data-source calls with this instead of writing try/catch blocks.
Future<Result<T>> safeApiCall<T>(Future<T> Function() call) async {
  try {
    return Ok(await call());
  } on Failure catch (failure) {
    return Err(failure);
  } on DioException catch (exception) {
    return Err(ApiErrorMapper.fromDioException(exception));
  } on Object catch (error, stackTrace) {
    AppLogger.error(
      'Unexpected error in API call',
      error: error,
      stackTrace: stackTrace,
      tag: 'Network',
    );
    return const Err(UnknownFailure());
  }
}
