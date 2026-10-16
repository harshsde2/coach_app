import 'package:json_annotation/json_annotation.dart';

part 'auth_requests.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequest {
  const LoginRequest({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class SignUpRequest {
  const SignUpRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class ForgotPasswordRequest {
  const ForgotPasswordRequest({required this.email});

  final String email;

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class VerifyResetCodeRequest {
  const VerifyResetCodeRequest({required this.email, required this.code});

  final String email;
  final String code;

  Map<String, dynamic> toJson() => _$VerifyResetCodeRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class ResetPasswordRequest {
  const ResetPasswordRequest({
    required this.resetToken,
    required this.password,
  });

  final String resetToken;
  final String password;

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
