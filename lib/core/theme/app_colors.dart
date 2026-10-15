import 'package:coach_app/core/config/tenant_config.dart';
import 'package:coach_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

/// Semantic colour tokens. Access with `context.colors`.
///
/// Neutrals depend on brightness; brand colours come from the tenant.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceRaised,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.brand,
    required this.brandSecondary,
    required this.onBrand,
    required this.brandSubtle,
    required this.avatar,
    required this.navigationBar,
    required this.error,
    required this.success,
    required this.warning,
  });

  factory AppColors.dark(TenantConfig tenant) => AppColors(
    background: AppPalette.ink,
    surface: AppPalette.panel,
    surfaceRaised: AppPalette.panelRaised,
    border: AppPalette.lineOnDark,
    textPrimary: AppPalette.textOnDark,
    textSecondary: AppPalette.mutedOnDark,
    textTertiary: AppPalette.subtleOnDark,
    brand: tenant.brandPrimary,
    brandSecondary: tenant.brandSecondary,
    onBrand: tenant.onBrand,
    brandSubtle: tenant.brandPrimary.withValues(alpha: 0.09),
    avatar: AppPalette.avatarOnDark,
    navigationBar: AppPalette.navOnDark,
    error: AppPalette.error,
    success: AppPalette.success,
    warning: AppPalette.warning,
  );

  factory AppColors.light(TenantConfig tenant) => AppColors(
    background: AppPalette.paper,
    surface: AppPalette.white,
    surfaceRaised: AppPalette.paperRaised,
    border: AppPalette.lineOnLight,
    textPrimary: AppPalette.textOnLight,
    textSecondary: AppPalette.mutedOnLight,
    textTertiary: AppPalette.subtleOnLight,
    brand: tenant.brandPrimary,
    brandSecondary: tenant.brandSecondary,
    onBrand: tenant.onBrand,
    brandSubtle: tenant.brandPrimary.withValues(alpha: 0.11),
    avatar: AppPalette.avatarOnLight,
    navigationBar: AppPalette.navOnLight,
    error: AppPalette.error,
    success: AppPalette.success,
    warning: AppPalette.warning,
  );

  /// Screen background.
  final Color background;

  /// Cards, inputs, sheets.
  final Color surface;

  /// Elements placed on top of a [surface].
  final Color surfaceRaised;

  /// Hairline borders and dividers.
  final Color border;

  final Color textPrimary;

  /// Supporting copy ("muted" in the design).
  final Color textSecondary;

  /// Eyebrow labels, placeholders, inactive icons.
  final Color textTertiary;

  /// Primary actions, active states, highlights.
  final Color brand;
  final Color brandSecondary;

  /// Text and icons placed on [brand].
  final Color onBrand;

  /// Low-emphasis brand tint (selected backgrounds).
  final Color brandSubtle;

  final Color avatar;
  final Color navigationBar;
  final Color error;
  final Color success;
  final Color warning;

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceRaised,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? brand,
    Color? brandSecondary,
    Color? onBrand,
    Color? brandSubtle,
    Color? avatar,
    Color? navigationBar,
    Color? error,
    Color? success,
    Color? warning,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      brand: brand ?? this.brand,
      brandSecondary: brandSecondary ?? this.brandSecondary,
      onBrand: onBrand ?? this.onBrand,
      brandSubtle: brandSubtle ?? this.brandSubtle,
      avatar: avatar ?? this.avatar,
      navigationBar: navigationBar ?? this.navigationBar,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      background: mix(background, other.background),
      surface: mix(surface, other.surface),
      surfaceRaised: mix(surfaceRaised, other.surfaceRaised),
      border: mix(border, other.border),
      textPrimary: mix(textPrimary, other.textPrimary),
      textSecondary: mix(textSecondary, other.textSecondary),
      textTertiary: mix(textTertiary, other.textTertiary),
      brand: mix(brand, other.brand),
      brandSecondary: mix(brandSecondary, other.brandSecondary),
      onBrand: mix(onBrand, other.onBrand),
      brandSubtle: mix(brandSubtle, other.brandSubtle),
      avatar: mix(avatar, other.avatar),
      navigationBar: mix(navigationBar, other.navigationBar),
      error: mix(error, other.error),
      success: mix(success, other.success),
      warning: mix(warning, other.warning),
    );
  }
}
