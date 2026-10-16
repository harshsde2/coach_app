// TODO(team): confirm paths against the fibodo API documentation.
abstract final class ApiEndpoints {
  static const login = '/auth/login';
  static const signUp = '/auth/register';
  static const refreshToken = '/auth/refresh';
  static const logout = '/auth/logout';
  static const forgotPassword = '/auth/password/forgot';
  static const verifyResetCode = '/auth/password/verify-otp';
  static const resetPassword = '/auth/password/reset';
  static const currentUser = '/me';
}
