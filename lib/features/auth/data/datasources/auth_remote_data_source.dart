import 'package:coach_app/core/config/app_config.dart';
import 'package:coach_app/core/network/api_client.dart';
import 'package:coach_app/features/auth/data/datasources/auth_api_data_source.dart';
import 'package:coach_app/features/auth/data/datasources/auth_mock_data_source.dart';
import 'package:coach_app/features/auth/data/models/auth_requests.dart';
import 'package:coach_app/features/auth/data/models/auth_response_dto.dart';
import 'package:coach_app/features/auth/data/models/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source.g.dart';

/// Auth endpoints of the backend. Implementations throw on failure
/// (`DioException` or `Failure`); the repository turns those into results.
abstract interface class AuthRemoteDataSource {
  Future<AuthResponseDto> login(LoginRequest request);

  Future<AuthResponseDto> signUp(SignUpRequest request);

  Future<UserDto> getCurrentUser();

  Future<void> logout();

  Future<void> requestPasswordReset(ForgotPasswordRequest request);

  Future<VerifyResetCodeResponseDto> verifyResetCode(
    VerifyResetCodeRequest request,
  );

  Future<void> resetPassword(ResetPasswordRequest request);
}

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  if (ref.watch(appConfigProvider).useMockApi) return AuthMockDataSource();
  return AuthApiDataSource(ref.watch(apiClientProvider));
}
