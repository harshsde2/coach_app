import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coach_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_controller.g.dart';

/// Submission state of the sign-up form: idle, loading, or error(Failure).
@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {}

  Future<void> submit({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRepositoryProvider)
        .signUp(fullName: fullName, email: email, password: password);
    if (!ref.mounted) return;

    switch (result) {
      case Ok(:final value):
        state = const AsyncData(null);
        ref.read(authControllerProvider.notifier).signedIn(value);
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
    }
  }
}
