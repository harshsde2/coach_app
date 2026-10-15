import 'package:coach_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Font families bundled in `assets/fonts` (see pubspec.yaml).
abstract final class AppFonts {
  /// Headings: bold, tight tracking.
  static const heading = 'Manrope';

  /// Body copy, labels, buttons.
  static const body = 'DMSans';
}

/// Semantic text styles. Access with `context.textStyles`.
///
/// Named by role, not size, so screens describe intent ("title") and the
/// design can be retuned here without touching any feature code.
@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.display,
    required this.headline,
    required this.title,
    required this.titleSmall,
    required this.bodyLarge,
    required this.body,
    required this.bodySmall,
    required this.label,
    required this.button,
    required this.eyebrow,
    required this.badge,
  });

  factory AppTextStyles.from(AppColors colors) {
    TextStyle heading(double size, FontWeight weight, double tracking) =>
        TextStyle(
          fontFamily: AppFonts.heading,
          fontSize: size,
          fontWeight: weight,
          letterSpacing: tracking,
          height: 1.15,
          color: colors.textPrimary,
        );

    TextStyle body(double size, FontWeight weight, {Color? color}) => TextStyle(
      fontFamily: AppFonts.body,
      fontSize: size,
      fontWeight: weight,
      height: 1.5,
      color: color ?? colors.textPrimary,
    );

    return AppTextStyles(
      display: heading(44, FontWeight.w700, -2.6).copyWith(height: 1),
      headline: heading(32, FontWeight.w800, -1.1),
      title: heading(26, FontWeight.w700, -1),
      titleSmall: heading(18, FontWeight.w700, -0.4),
      bodyLarge: body(16, FontWeight.w400),
      body: body(14, FontWeight.w400),
      bodySmall: body(12, FontWeight.w400, color: colors.textSecondary),
      label: body(13, FontWeight.w600),
      button: body(15, FontWeight.w800).copyWith(height: 1.2),
      eyebrow: body(
        11.5,
        FontWeight.w700,
        color: colors.textTertiary,
      ).copyWith(letterSpacing: 1.8, height: 1.3),
      badge: body(
        10,
        FontWeight.w800,
        color: colors.onBrand,
      ).copyWith(letterSpacing: 1.2, height: 1.2),
    );
  }

  /// Hero headings ("Lower body power.").
  final TextStyle display;

  /// Screen-level headings on standalone screens ("Welcome back.").
  final TextStyle headline;

  /// Section and tab headings ("Your bookings.").
  final TextStyle title;

  /// Card titles.
  final TextStyle titleSmall;

  final TextStyle bodyLarge;
  final TextStyle body;

  /// Captions and helper text (secondary colour).
  final TextStyle bodySmall;

  /// Form field labels.
  final TextStyle label;
  final TextStyle button;

  /// Small uppercase label above titles. Uppercase the text yourself or use
  /// the `Eyebrow` widget.
  final TextStyle eyebrow;

  /// Pills and status chips on brand colour.
  final TextStyle badge;

  @override
  AppTextStyles copyWith({
    TextStyle? display,
    TextStyle? headline,
    TextStyle? title,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? body,
    TextStyle? bodySmall,
    TextStyle? label,
    TextStyle? button,
    TextStyle? eyebrow,
    TextStyle? badge,
  }) {
    return AppTextStyles(
      display: display ?? this.display,
      headline: headline ?? this.headline,
      title: title ?? this.title,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      body: body ?? this.body,
      bodySmall: bodySmall ?? this.bodySmall,
      label: label ?? this.label,
      button: button ?? this.button,
      eyebrow: eyebrow ?? this.eyebrow,
      badge: badge ?? this.badge,
    );
  }

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other == null) return this;
    TextStyle mix(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;
    return AppTextStyles(
      display: mix(display, other.display),
      headline: mix(headline, other.headline),
      title: mix(title, other.title),
      titleSmall: mix(titleSmall, other.titleSmall),
      bodyLarge: mix(bodyLarge, other.bodyLarge),
      body: mix(body, other.body),
      bodySmall: mix(bodySmall, other.bodySmall),
      label: mix(label, other.label),
      button: mix(button, other.button),
      eyebrow: mix(eyebrow, other.eyebrow),
      badge: mix(badge, other.badge),
    );
  }
}
