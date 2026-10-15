import 'package:coach_app/core/router/app_routes.dart';
import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/async_value_ui.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/utils/validators.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:coach_app/features/auth/presentation/providers/sign_up_controller.dart';
import 'package:coach_app/features/auth/presentation/widgets/auth_footer_prompt.dart';
import 'package:coach_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref
        .read(signUpControllerProvider.notifier)
        .submit(
          fullName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      signUpControllerProvider,
      (_, state) => state.showErrorToast(context),
    );
    final isLoading = ref.watch(signUpControllerProvider).isLoading;
    final l10n = context.l10n;

    return AppScaffold(
      maxContentWidth: AppSizes.formMaxWidth,
      body: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(title: l10n.signUpTitle),
              const SizedBox(height: AppSpacing.xxl),
              AppTextField(
                label: l10n.fullNameLabel,
                hint: l10n.fullNameHint,
                controller: _nameController,
                validator: Validators.required(l10n),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                label: l10n.emailLabel,
                hint: l10n.emailHint,
                controller: _emailController,
                validator: Validators.email(l10n),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPasswordField(
                label: l10n.passwordLabel,
                hint: l10n.newPasswordHint,
                controller: _passwordController,
                validator: Validators.password(l10n),
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
              ),
              const SizedBox(height: AppSpacing.md),
              AppCheckboxField(
                label: l10n.acceptTerms,
                validator: (accepted) =>
                    accepted ?? false ? null : l10n.validationAcceptTerms,
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton.primary(
                label: l10n.signUpButton,
                icon: Icons.arrow_forward,
                isLoading: isLoading,
                onPressed: _submit,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthFooterPrompt(
                prompt: l10n.haveAccountPrompt,
                actionLabel: l10n.loginLink,
                onAction: () => context.go(AppRoutes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
