import 'package:coach_app/core/constants/storage_keys.dart';
import 'package:coach_app/core/storage/auth_tokens.dart';
import 'package:coach_app/core/storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_storage.g.dart';

/// Persists the session tokens in secure storage.
///
/// Lives in `core` because the network layer needs it to authorise requests.
class TokenStorage {
  const TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<AuthTokens?> read() async {
    final accessToken = await _storage.read(key: StorageKeys.accessToken);
    final refreshToken = await _storage.read(key: StorageKeys.refreshToken);
    if (accessToken == null || refreshToken == null) return null;
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<void> save(AuthTokens tokens) async {
    await _storage.write(
      key: StorageKeys.accessToken,
      value: tokens.accessToken,
    );
    await _storage.write(
      key: StorageKeys.refreshToken,
      value: tokens.refreshToken,
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) =>
    TokenStorage(ref.watch(secureStorageProvider));
