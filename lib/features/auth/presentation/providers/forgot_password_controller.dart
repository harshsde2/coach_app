import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_controller.freezed.dart';
part 'forgot_password_controller.g.dart';

enum ForgotPasswordStep { email, code, newPassword, completed }

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(ForgotPasswordStep.email) ForgotPasswordStep step,
    @Default('') String email,
    String? resetToken,
    @Default(false) bool isSubmitting,

    /// Latest failure; a new instance each time, so listeners can react
    /// to repeated identical errors.
    Failure? failure,
  }) = _ForgotPasswordState;
}

@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();

  Future<void> requestCode(String email) async {
    final result = await _run(
      () => ref.read(authRepositoryProvider).requestPasswordReset(email: email),
    );
    if (result is Ok) {
      state = state.copyWith(step: ForgotPasswordStep.code, email: email);
    }
  }

  /// Returns whether a new code was sent.
  Future<bool> resendCode() async {
    final result = await _run(
      () => ref
          .read(authRepositoryProvider)
          .requestPasswordReset(email: state.email),
    );
    return result is Ok;
  }

  Future<void> verifyCode(String code) async {
    final result = await _run(
      () => ref
          .read(authRepositoryProvider)
          .verifyResetCode(email: state.email, code: code),
    );
    if (result case Ok(:final value)) {
      state = state.copyWith(
        step: ForgotPasswordStep.newPassword,
        resetToken: value,
      );
    }
  }

  Future<void> resetPassword(String newPassword) async {
    final result = await _run(
      () => ref
          .read(authRepositoryProvider)
          .resetPassword(
            resetToken: state.resetToken!,
            newPassword: newPassword,
          ),
    );
    if (result is Ok) {
      state = state.copyWith(step: ForgotPasswordStep.completed);
    }
  }

  void editEmail() => state = state.copyWith(step: ForgotPasswordStep.email);

  /// Returns `null` if the provider was disposed meanwhile.
  Future<Result<T>?> _run<T>(Future<Result<T>> Function() call) async {
    state = state.copyWith(isSubmitting: true, failure: null);
    final result = await call();
    if (!ref.mounted) return null;

    state = state.copyWith(
      isSubmitting: false,
      failure: switch (result) {
        Ok() => null,
        Err(:final failure) => failure,
      },
    );
    return result;
  }
}
