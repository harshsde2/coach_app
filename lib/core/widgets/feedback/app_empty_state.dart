import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/display/icon_chip.dart';
import 'package:flutter/material.dart';

/// Placeholder for empty lists, errors and not-yet-built sections.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    super.key,
  });

  final IconData icon;
  final String title;
  final String message;

  /// Optional call to action, typically an `AppButton`.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconChip(icon: icon, size: 56),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: textStyles.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: textStyles.body.copyWith(
                color: context.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
