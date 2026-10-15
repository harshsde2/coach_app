import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// The signed-in member.
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? avatarUrl,
  }) = _User;

  const User._();

  String get fullName => '$firstName $lastName'.trim();

  /// Up to two initials for avatars, e.g. "AM".
  String get initials => [firstName, lastName]
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase())
      .join();
}
