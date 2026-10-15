import 'package:coach_app/core/storage/auth_tokens.dart';
import 'package:coach_app/features/auth/data/models/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

/// Response of login / sign-up.
@freezed
abstract class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required String accessToken,
    required String refreshToken,
    required UserDto user,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);

  const AuthResponseDto._();

  AuthTokens get tokens =>
      AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
}

/// Response of verifying a password-reset code.
@freezed
abstract class VerifyResetCodeResponseDto with _$VerifyResetCodeResponseDto {
  const factory VerifyResetCodeResponseDto({required String resetToken}) =
      _VerifyResetCodeResponseDto;

  factory VerifyResetCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseDtoFromJson(json);
}
