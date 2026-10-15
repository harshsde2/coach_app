// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponseDto _$AuthResponseDtoFromJson(Map<String, dynamic> json) =>
    _AuthResponseDto(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseDtoToJson(_AuthResponseDto instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user': instance.user.toJson(),
    };

_VerifyResetCodeResponseDto _$VerifyResetCodeResponseDtoFromJson(
  Map<String, dynamic> json,
) => _VerifyResetCodeResponseDto(resetToken: json['reset_token'] as String);

Map<String, dynamic> _$VerifyResetCodeResponseDtoToJson(
  _VerifyResetCodeResponseDto instance,
) => <String, dynamic>{'reset_token': instance.resetToken};
