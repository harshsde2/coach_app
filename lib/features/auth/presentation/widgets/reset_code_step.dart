import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/utils/validators.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Step 2 of password reset: enter the emailed one-time code.
class ResetCodeStep extends StatefulWidget {
  const ResetCodeStep({
    required this.isSubmitting,
    required this.onSubmit,
    required this.onResend,
    required this.onChangeEmail,
    super.key,
  });

  final bool isSubmitting;
  final ValueChanged<String> onSubmit;
  final VoidCallback onResend;
  final VoidCallback onChangeEmail;

  @override
  State<ResetCodeStep> createState() => _ResetCodeStepState();
}

class _ResetCodeStepState extends State<ResetCodeStep> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_codeController.text);
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
            label: l10n.otpLabel,
            hint: l10n.otpHint,
            controller: _codeController,
            validator: Validators.otp(l10n),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.oneTimeCode],
            autofocus: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(Validators.otpLength),
            ],
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.primary(
            label: l10n.verifyCodeButton,
            icon: Icons.arrow_forward,
            isLoading: widget.isSubmitting,
            onPressed: _submit,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              AppButton.text(
                label: l10n.resendCodeButton,
                onPressed: widget.isSubmitting ? null : widget.onResend,
              ),
              AppButton.text(
                label: l10n.changeEmailButton,
                onPressed: widget.isSubmitting ? null : widget.onChangeEmail,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
