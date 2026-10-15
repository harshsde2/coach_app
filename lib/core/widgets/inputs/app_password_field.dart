import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/inputs/app_text_field.dart';
import 'package:flutter/material.dart';

/// [AppTextField] with obscured input and a show/hide toggle.
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    required this.label,
    this.controller,
    this.hint,
    this.helperText,
    this.validator,
    this.textInputAction,
    this.autofillHints = const [AutofillHints.password],
    this.onFieldSubmitted,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helperText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final Iterable<String> autofillHints;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppTextField(
      label: widget.label,
      controller: widget.controller,
      hint: widget.hint,
      helperText: widget.helperText,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscured,
      suffix: IconButton(
        tooltip: _obscured ? l10n.showPassword : l10n.hidePassword,
        onPressed: () => setState(() => _obscured = !_obscured),
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: context.colors.textTertiary,
        ),
      ),
    );
  }
}
