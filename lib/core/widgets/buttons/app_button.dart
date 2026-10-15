import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { primary, outline, text }

/// The app's single button component.
///
/// ```dart
/// AppButton.primary(label: l10n.loginButton, onPressed: submit)
/// AppButton.outline(label: l10n.logoutButton, icon: Icons.logout, …)
/// AppButton.text(label: l10n.forgotPasswordLink, onPressed: …)
/// ```
///
/// Passing `onPressed: null` renders the disabled state.
class AppButton extends StatelessWidget {
  const AppButton.primary({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expanded = true,
    super.key,
  }) : variant = AppButtonVariant.primary;

  const AppButton.outline({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expanded = true,
    super.key,
  }) : variant = AppButtonVariant.outline;

  const AppButton.text({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  }) : variant = AppButtonVariant.text,
       isLoading = false,
       expanded = false;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;

  /// Optional trailing icon.
  final IconData? icon;

  /// Shows a spinner and blocks taps, keeping the button's size.
  final bool isLoading;

  /// Fill the available width.
  final bool expanded;

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (background, foreground, borderColor) = switch (variant) {
      AppButtonVariant.primary => (colors.brand, colors.onBrand, null),
      AppButtonVariant.outline => (
        colors.surface,
        colors.textPrimary,
        colors.border,
      ),
      AppButtonVariant.text => (Colors.transparent, colors.brand, null),
    };
    final isText = variant == AppButtonVariant.text;
    final textStyle = context.textStyles.button.copyWith(
      color: foreground,
      fontSize: isText ? 14 : null,
      fontWeight: isText ? FontWeight.w700 : null,
    );

    return Semantics(
      button: true,
      enabled: _isEnabled,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: onPressed == null ? 0.45 : 1,
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.button,
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _isEnabled ? onPressed : null,
            child: SizedBox(
              height: isText
                  ? AppSizes.buttonHeightSmall
                  : AppSizes.buttonHeight,
              width: expanded ? double.infinity : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isText ? AppSpacing.xxs : AppSpacing.lg,
                ),
                child: isLoading
                    ? Center(child: _Spinner(color: foreground))
                    : _Content(
                        label: label,
                        icon: icon,
                        style: textStyle,
                        expanded: expanded,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.label,
    required this.icon,
    required this.style,
    required this.expanded,
  });

  final String label;
  final IconData? icon;
  final TextStyle style;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(label, style: style, overflow: TextOverflow.ellipsis),
        ),
        if (icon != null) ...[
          const SizedBox(width: AppSpacing.xs),
          Icon(icon, size: AppSizes.iconMd, color: style.color),
        ],
      ],
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppSizes.iconMd,
      child: CircularProgressIndicator(strokeWidth: 2.2, color: color),
    );
  }
}
