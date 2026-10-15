import 'package:coach_app/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// Reusable form validators returning localised messages.
///
/// ```dart
/// AppTextField(validator: Validators.email(context.l10n));
/// ```
abstract final class Validators {
  static const minPasswordLength = 8;
  static const otpLength = 6;

  static final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  static final _digitsPattern = RegExp(r'^\d+$');

  static FormFieldValidator<String> required(AppLocalizations l10n) =>
      (value) => (value == null || value.trim().isEmpty)
      ? l10n.validationRequired
      : null;

  static FormFieldValidator<String> email(AppLocalizations l10n) => (value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return l10n.validationRequired;
    return _emailPattern.hasMatch(email) ? null : l10n.validationEmail;
  };

  static FormFieldValidator<String> password(AppLocalizations l10n) => (value) {
    final password = value ?? '';
    if (password.isEmpty) return l10n.validationRequired;
    return password.length < minPasswordLength
        ? l10n.validationPasswordLength(minPasswordLength)
        : null;
  };

  /// [original] is read lazily so it always compares the latest input.
  static FormFieldValidator<String> confirmPassword(
    AppLocalizations l10n,
    String Function() original,
  ) => (value) {
    if (value == null || value.isEmpty) return l10n.validationRequired;
    return value == original() ? null : l10n.validationPasswordMismatch;
  };

  static FormFieldValidator<String> otp(AppLocalizations l10n) => (value) {
    final code = value?.trim() ?? '';
    final isValid = code.length == otpLength && _digitsPattern.hasMatch(code);
    return isValid ? null : l10n.validationOtp(otpLength);
  };
}
