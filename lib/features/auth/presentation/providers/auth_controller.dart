import 'dart:async';

import 'package:coach_app/core/network/session_events.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// loading = restoring the session, data(user) = signed in,
/// data(null) = signed out. The router guards routes from this state, so
/// updating it is all that signing in or out needs to do.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<User?> build() async {
    final subscription = ref
        .watch(sessionEventsProvider)
        .onExpired
        .listen((_) => unawaited(logout()));
    ref.onDispose(subscription.cancel);

    final result = await ref.watch(authRepositoryProvider).restoreSession();
    return switch (result) {
      Ok(:final value) => value,
      Err() => null,
    };
  }

  void signedIn(User user) => state = AsyncData(user);

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}

@riverpod
User? currentUser(Ref ref) => ref.watch(authControllerProvider).value;
