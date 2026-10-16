import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

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

  String get initials => [firstName, lastName]
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase())
      .join();
}
