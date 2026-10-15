import 'package:coach_app/core/theme/app_colors.dart';
import 'package:coach_app/core/theme/app_typography.dart';
import 'package:coach_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Short, typed access to design tokens and strings from any widget:
/// `context.colors.brand`, `context.textStyles.title`, `context.l10n.login`.
extension BuildContextX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;

  AppLocalizations get l10n => AppLocalizations.of(this);
}
