import 'package:coach_app/core/router/app_router.dart';
import 'package:coach_app/core/router/app_routes.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

void main() {
  const restoring = AsyncLoading<User?>();
  const signedOut = AsyncData<User?>(null);
  const signedIn = AsyncData<User?>(testUser);

  group('authGuard', () {
    test('holds every route on splash while restoring the session', () {
      expect(authGuard(restoring, AppRoutes.home), AppRoutes.splash);
      expect(authGuard(restoring, AppRoutes.splash), isNull);
    });

    test('sends signed-out users to login', () {
      expect(authGuard(signedOut, AppRoutes.profile), AppRoutes.login);
      expect(authGuard(signedOut, AppRoutes.splash), AppRoutes.login);
    });

    test('lets signed-out users move between auth screens', () {
      expect(authGuard(signedOut, AppRoutes.signUp), isNull);
      expect(authGuard(signedOut, AppRoutes.forgotPassword), isNull);
    });

    test('keeps signed-in users out of auth screens', () {
      expect(authGuard(signedIn, AppRoutes.login), AppRoutes.home);
      expect(authGuard(signedIn, AppRoutes.splash), AppRoutes.home);
      expect(authGuard(signedIn, AppRoutes.profile), isNull);
    });
  });
}
