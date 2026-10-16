import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Result<User>> login({required String email, required String password});

  Future<Result<User>> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  /// Restores a persisted session. Resolves to `Ok(null)` when signed out.
  Future<Result<User?>> restoreSession();

  /// Ends the session locally; the server is notified on a best-effort basis.
  Future<void> logout();

  Future<Result<void>> requestPasswordReset({required String email});

  /// Exchanges the emailed code for a short-lived reset token.
  Future<Result<String>> verifyResetCode({
    required String email,
    required String code,
  });

  Future<Result<void>> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}
