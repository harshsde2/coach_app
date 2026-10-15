import 'dart:async';

import 'package:coach_app/core/network/session_events.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// Source of truth for "who is signed in".
///
/// * loading → session is being restored (splash screen)
/// * data(User) → signed in
/// * data(null) → signed out
///
/// The router listens to this provider to guard routes, so signing in or
/// out anywhere automatically moves the user to the right screen.
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

  /// Called by the login / sign-up flows once a session has been created.
  void signedIn(User user) => state = AsyncData(user);

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}

/// The signed-in user, or `null` when signed out or still loading.
@riverpod
User? currentUser(Ref ref) => ref.watch(authControllerProvider).value;
