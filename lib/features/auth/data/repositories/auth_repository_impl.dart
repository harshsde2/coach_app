import 'package:coach_app/core/network/safe_api_call.dart';
import 'package:coach_app/core/storage/token_storage.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:coach_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coach_app/features/auth/data/models/auth_requests.dart';
import 'package:coach_app/features/auth/data/models/auth_response_dto.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:coach_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this._remote,
    required this._local,
    required this._tokenStorage,
  });

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final TokenStorage _tokenStorage;

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) => safeApiCall(() async {
    final response = await _remote.login(
      LoginRequest(email: _normalise(email), password: password),
    );
    return await _startSession(response);
  });

  @override
  Future<Result<User>> signUp({
    required String fullName,
    required String email,
    required String password,
  }) => safeApiCall(() async {
    final response = await _remote.signUp(
      SignUpRequest(
        fullName: fullName.trim(),
        email: _normalise(email),
        password: password,
      ),
    );
    return await _startSession(response);
  });

  @override
  Future<Result<User?>> restoreSession() => safeApiCall(() async {
    if (await _tokenStorage.read() == null) return null;

    // Cached user first: instant, offline-friendly start. An expired token
    // is caught by the auth interceptor on the next request.
    final cached = await _local.readUser();
    if (cached != null) return cached.toEntity();

    final user = await _remote.getCurrentUser();
    await _local.saveUser(user);
    return user.toEntity();
  });

  @override
  Future<void> logout() async {
    // Best effort: local sign-out must succeed even when offline.
    await safeApiCall(_remote.logout);
    await _tokenStorage.clear();
    await _local.clear();
  }

  @override
  Future<Result<void>> requestPasswordReset({required String email}) =>
      safeApiCall(
        () => _remote.requestPasswordReset(
          ForgotPasswordRequest(email: _normalise(email)),
        ),
      );

  @override
  Future<Result<String>> verifyResetCode({
    required String email,
    required String code,
  }) => safeApiCall(() async {
    final response = await _remote.verifyResetCode(
      VerifyResetCodeRequest(email: _normalise(email), code: code.trim()),
    );
    return response.resetToken;
  });

  @override
  Future<Result<void>> resetPassword({
    required String resetToken,
    required String newPassword,
  }) => safeApiCall(
    () => _remote.resetPassword(
      ResetPasswordRequest(resetToken: resetToken, password: newPassword),
    ),
  );

  Future<User> _startSession(AuthResponseDto response) async {
    await _tokenStorage.save(response.tokens);
    await _local.saveUser(response.user);
    return response.user.toEntity();
  }

  String _normalise(String email) => email.trim().toLowerCase();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
  remote: ref.watch(authRemoteDataSourceProvider),
  local: ref.watch(authLocalDataSourceProvider),
  tokenStorage: ref.watch(tokenStorageProvider),
);
