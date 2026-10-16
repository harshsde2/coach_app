import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AuthFooterPrompt extends StatelessWidget {
  const AuthFooterPrompt({
    required this.prompt,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          prompt,
          style: context.textStyles.body.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        AppButton.text(label: actionLabel, onPressed: onAction),
      ],
    );
  }
}
