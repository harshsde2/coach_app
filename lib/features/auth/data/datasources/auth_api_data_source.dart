import 'package:coach_app/core/network/api_endpoints.dart';
import 'package:coach_app/core/network/interceptors/auth_interceptor.dart';
import 'package:coach_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coach_app/features/auth/data/models/auth_requests.dart';
import 'package:coach_app/features/auth/data/models/auth_response_dto.dart';
import 'package:coach_app/features/auth/data/models/user_dto.dart';
import 'package:dio/dio.dart';

/// [AuthRemoteDataSource] backed by the fibodo REST API.
class AuthApiDataSource implements AuthRemoteDataSource {
  const AuthApiDataSource(this._dio);

  final Dio _dio;

  /// Public endpoints must not carry (or try to refresh) a session token.
  static final _public = Options(extra: {AuthInterceptor.skipAuth: true});

  @override
  Future<AuthResponseDto> login(LoginRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: request.toJson(),
      options: _public,
    );
    return AuthResponseDto.fromJson(response.data!);
  }

  @override
  Future<AuthResponseDto> signUp(SignUpRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.signUp,
      data: request.toJson(),
      options: _public,
    );
    return AuthResponseDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> getCurrentUser() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.currentUser,
    );
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<void> logout() => _dio.post<void>(ApiEndpoints.logout);

  @override
  Future<void> requestPasswordReset(ForgotPasswordRequest request) =>
      _dio.post<void>(
        ApiEndpoints.forgotPassword,
        data: request.toJson(),
        options: _public,
      );

  @override
  Future<VerifyResetCodeResponseDto> verifyResetCode(
    VerifyResetCodeRequest request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.verifyResetCode,
      data: request.toJson(),
      options: _public,
    );
    return VerifyResetCodeResponseDto.fromJson(response.data!);
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) => _dio.post<void>(
    ApiEndpoints.resetPassword,
    data: request.toJson(),
    options: _public,
  );
}
