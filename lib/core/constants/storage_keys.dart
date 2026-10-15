/// Keys for values persisted on device. Kept together to avoid collisions.
abstract final class StorageKeys {
  static const accessToken = 'auth.access_token';
  static const refreshToken = 'auth.refresh_token';
  static const cachedUser = 'auth.cached_user';
}
