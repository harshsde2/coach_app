import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error, info }

extension AppToast on BuildContext {
  /// Shows a short, non-blocking message at the bottom of the screen.
  void showToast(String message, {ToastType type = ToastType.info}) {
    final colors = this.colors;
    final (icon, iconColor) = switch (type) {
      ToastType.success => (Icons.check_circle_outline, colors.success),
      ToastType.error => (Icons.error_outline, colors.error),
      ToastType.info => (Icons.info_outline, colors.brand),
    };

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: iconColor, size: AppSizes.iconMd),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }
}
