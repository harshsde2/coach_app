abstract final class AppRoutes {
  static const splash = '/splash';

  // Auth: nested under /login so the back stack is login → sign-up.
  static const login = '/login';
  static const signUp = '/login/sign-up';
  static const forgotPassword = '/login/forgot-password';

  static const home = '/home';
  static const wallet = '/wallet';
  static const messages = '/messages';
  static const contacts = '/contacts';
  static const profile = '/profile';

  static bool isAuthRoute(String location) => location.startsWith(login);
}
