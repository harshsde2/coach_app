import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/utils/validators.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Step 1 of password reset: collect the account email.
class ResetEmailStep extends StatefulWidget {
  const ResetEmailStep({
    required this.initialEmail,
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
  });

  final String initialEmail;
  final bool isSubmitting;
  final ValueChanged<String> onSubmit;

  @override
  State<ResetEmailStep> createState() => _ResetEmailStepState();
}

class _ResetEmailStepState extends State<ResetEmailStep> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController = TextEditingController(
    text: widget.initialEmail,
  );

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: l10n.emailLabel,
            hint: l10n.emailHint,
            controller: _emailController,
            validator: Validators.email(l10n),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.email],
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.primary(
            label: l10n.requestCodeButton,
            icon: Icons.arrow_forward,
            isLoading: widget.isSubmitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
