import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

/// Asks the user to confirm an action. Resolves to `true` when confirmed.
Future<bool> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String? cancelLabel,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton.outline(
                label: cancelLabel ?? dialogContext.l10n.cancel,
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton.primary(
                label: confirmLabel,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
