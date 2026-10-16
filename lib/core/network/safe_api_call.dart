import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/core/logging/app_logger.dart';
import 'package:coach_app/core/network/api_error_mapper.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:dio/dio.dart';

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
