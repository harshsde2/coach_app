import 'package:coach_app/core/constants/app_durations.dart';
import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coach_app/features/auth/data/models/auth_requests.dart';
import 'package:coach_app/features/auth/data/models/auth_response_dto.dart';
import 'package:coach_app/features/auth/data/models/user_dto.dart';

/// In-memory [AuthRemoteDataSource] for development without a backend.
///
/// Demo rules:
/// * any email/password signs in, except [rejectedEmail];
/// * sign-up fails for [takenEmail];
/// * the password-reset code is [validResetCode].
class AuthMockDataSource implements AuthRemoteDataSource {
  AuthMockDataSource({this.latency = AppDurations.mockLatency});

  static const rejectedEmail = 'wrong@example.com';
  static const takenEmail = 'taken@example.com';
  static const validResetCode = '123456';

  final Duration latency;

  UserDto? _user;

  @override
  Future<AuthResponseDto> login(LoginRequest request) async {
    await Future<void>.delayed(latency);
    if (request.email == rejectedEmail) {
      throw const ValidationFailure('Incorrect email or password.');
    }
    return _session(_userFrom(name: 'Alex Morgan', email: request.email));
  }

  @override
  Future<AuthResponseDto> signUp(SignUpRequest request) async {
    await Future<void>.delayed(latency);
    if (request.email == takenEmail) {
      throw const ValidationFailure(
        'An account with this email already exists.',
      );
    }
    return _session(_userFrom(name: request.fullName, email: request.email));
  }

  @override
  Future<UserDto> getCurrentUser() async {
    await Future<void>.delayed(latency);
    return _user ?? _userFrom(name: 'Alex Morgan', email: 'alex@example.com');
  }

  @override
  Future<void> logout() async => _user = null;

  @override
  Future<void> requestPasswordReset(ForgotPasswordRequest request) =>
      Future<void>.delayed(latency);

  @override
  Future<VerifyResetCodeResponseDto> verifyResetCode(
    VerifyResetCodeRequest request,
  ) async {
    await Future<void>.delayed(latency);
    if (request.code != validResetCode) {
      throw const ValidationFailure('That code is incorrect or has expired.');
    }
    return const VerifyResetCodeResponseDto(resetToken: 'mock-reset-token');
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) =>
      Future<void>.delayed(latency);

  AuthResponseDto _session(UserDto user) {
    _user = user;
    final issuedAt = DateTime.now().millisecondsSinceEpoch;
    return AuthResponseDto(
      accessToken: 'mock-access-$issuedAt',
      refreshToken: 'mock-refresh-$issuedAt',
      user: user,
    );
  }

  UserDto _userFrom({required String name, required String email}) {
    final parts = name.trim().split(RegExp(r'\s+'));
    return UserDto(
      id: 'mock-${email.hashCode}',
      firstName: parts.first,
      lastName: parts.skip(1).join(' '),
      email: email,
    );
  }
}
