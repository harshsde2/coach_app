import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/utils/validators.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ResetPasswordStep extends StatefulWidget {
  const ResetPasswordStep({
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
  });

  final bool isSubmitting;
  final ValueChanged<String> onSubmit;

  @override
  State<ResetPasswordStep> createState() => _ResetPasswordStepState();
}

class _ResetPasswordStepState extends State<ResetPasswordStep> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPasswordField(
              label: l10n.newPasswordLabel,
              hint: l10n.newPasswordHint,
              controller: _passwordController,
              validator: Validators.password(l10n),
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppPasswordField(
              label: l10n.confirmPasswordLabel,
              hint: l10n.confirmPasswordHint,
              controller: _confirmController,
              validator: Validators.confirmPassword(
                l10n,
                () => _passwordController.text,
              ),
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton.primary(
              label: l10n.savePasswordButton,
              icon: Icons.lock_outline,
              isLoading: widget.isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
