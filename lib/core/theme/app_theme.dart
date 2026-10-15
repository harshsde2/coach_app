import 'package:coach_app/core/config/tenant_config.dart';
import 'package:coach_app/core/theme/app_colors.dart';
import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

/// Builds [ThemeData] from the design tokens.
///
/// Material widgets (TextField, SnackBar, Dialog…) are themed here so they
/// match the design even when used directly; custom tokens are attached as
/// [ThemeExtension]s for our own components.
abstract final class AppTheme {
  static ThemeData dark(TenantConfig tenant) =>
      _build(AppColors.dark(tenant), Brightness.dark);

  static ThemeData light(TenantConfig tenant) =>
      _build(AppColors.light(tenant), Brightness.light);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final text = AppTextStyles.from(colors);
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.brand,
      onPrimary: colors.onBrand,
      secondary: colors.brandSecondary,
      onSecondary: colors.onBrand,
      error: colors.error,
      onError: colors.onBrand,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      outline: colors.border,
      outlineVariant: colors.border,
    );

    final inputBorder = OutlineInputBorder(
      borderRadius: AppRadius.input,
      borderSide: BorderSide(color: colors.border),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      fontFamily: AppFonts.body,
      splashFactory: InkSparkle.splashFactory,
      extensions: [colors, text],
      textTheme: TextTheme(
        displayLarge: text.display,
        headlineMedium: text.headline,
        titleLarge: text.title,
        titleMedium: text.titleSmall,
        bodyLarge: text.bodyLarge,
        bodyMedium: text.body,
        bodySmall: text.bodySmall,
        labelLarge: text.button,
        labelMedium: text.label,
        labelSmall: text.eyebrow,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: colors.textPrimary,
        titleTextStyle: text.titleSmall,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        hintStyle: text.body.copyWith(color: colors.textTertiary),
        errorStyle: text.bodySmall.copyWith(color: colors.error),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: colors.brand, width: 1.5),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.brand,
        selectionColor: colors.brand.withValues(alpha: 0.3),
        selectionHandleColor: colors.brand,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colors.brand
              : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll(colors.onBrand),
        side: BorderSide(color: colors.textTertiary, width: 1.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.xs)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.surfaceRaised,
        contentTextStyle: text.body,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
        titleTextStyle: text.titleSmall,
        contentTextStyle: text.body.copyWith(color: colors.textSecondary),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.brand),
    );
  }
}

/// Current theme mode. Dark by default, matching the FORM design.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ThemeMode.dark;

  // ignore: use_setters_to_change_properties, notifier API reads better.
  void set(ThemeMode mode) => state = mode;
}
