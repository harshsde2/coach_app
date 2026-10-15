import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// API representation of a user. Mapped to [User] before leaving the
/// data layer, so API changes never ripple into the UI.
@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? avatarUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  const UserDto._();

  User toEntity() => User(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    avatarUrl: avatarUrl,
  );
}
