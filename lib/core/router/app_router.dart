import 'package:coach_app/core/router/app_routes.dart';
import 'package:coach_app/core/router/scaffold_with_nav_bar.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:coach_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:coach_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:coach_app/features/auth/presentation/screens/login_screen.dart';
import 'package:coach_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:coach_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:coach_app/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:coach_app/features/home/presentation/screens/home_screen.dart';
import 'package:coach_app/features/messages/presentation/screens/messages_screen.dart';
import 'package:coach_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:coach_app/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Bridges Riverpod → Listenable so GoRouter re-runs `redirect` whenever
  // the auth state changes, without rebuilding the router itself.
  final authState = ValueNotifier<AsyncValue<User?>>(const AsyncLoading());
  ref
    ..onDispose(authState.dispose)
    ..listen(
      authControllerProvider,
      (_, next) => authState.value = next,
      fireImmediately: true,
    );

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: authState,
    redirect: (context, state) =>
        _guard(authState.value, state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: _child(AppRoutes.signUp),
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            path: _child(AppRoutes.forgotPassword),
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          _tab(AppRoutes.home, const HomeScreen()),
          _tab(AppRoutes.wallet, const WalletScreen()),
          _tab(AppRoutes.messages, const MessagesScreen()),
          _tab(AppRoutes.contacts, const ContactsScreen()),
          _tab(AppRoutes.profile, const ProfileScreen()),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
}

@visibleForTesting
String? authGuard(AsyncValue<User?> auth, String location) =>
    _guard(auth, location);

String? _guard(AsyncValue<User?> auth, String location) {
  final isRestoring = auth.isLoading && !auth.hasValue;
  if (isRestoring) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  final isSignedIn = auth.value != null;
  final onAuthRoute = AppRoutes.isAuthRoute(location);

  if (!isSignedIn) return onAuthRoute ? null : AppRoutes.login;
  if (onAuthRoute || location == AppRoutes.splash) return AppRoutes.home;
  return null;
}

StatefulShellBranch _tab(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => screen)],
);

String _child(String fullPath) => fullPath.split('/').last;
