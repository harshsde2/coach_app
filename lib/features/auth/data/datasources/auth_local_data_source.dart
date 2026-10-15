import 'dart:convert';

import 'package:coach_app/core/constants/storage_keys.dart';
import 'package:coach_app/core/storage/secure_storage.dart';
import 'package:coach_app/features/auth/data/models/user_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_data_source.g.dart';

/// Caches the signed-in user so the app opens instantly (and offline)
/// without waiting for the network.
class AuthLocalDataSource {
  const AuthLocalDataSource(this._storage);

  final FlutterSecureStorage _storage;

  Future<UserDto?> readUser() async {
    final raw = await _storage.read(key: StorageKeys.cachedUser);
    if (raw == null) return null;
    try {
      return UserDto.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on FormatException {
      await clear();
      return null;
    }
  }

  Future<void> saveUser(UserDto user) => _storage.write(
    key: StorageKeys.cachedUser,
    value: jsonEncode(user.toJson()),
  );

  Future<void> clear() => _storage.delete(key: StorageKeys.cachedUser);
}

@Riverpod(keepAlive: true)
AuthLocalDataSource authLocalDataSource(Ref ref) =>
    AuthLocalDataSource(ref.watch(secureStorageProvider));
