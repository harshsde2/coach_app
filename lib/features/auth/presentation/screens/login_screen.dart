import 'package:coach_app/core/config/tenant_config.dart';
import 'package:coach_app/core/router/app_routes.dart';
import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/async_value_ui.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/utils/validators.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:coach_app/features/auth/presentation/providers/login_controller.dart';
import 'package:coach_app/features/auth/presentation/widgets/auth_footer_prompt.dart';
import 'package:coach_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref
        .read(loginControllerProvider.notifier)
        .submit(
          email: _emailController.text,
          password: _passwordController.text,
        );
    // Success needs no navigation here: the router redirects once the
    // auth state changes.
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginControllerProvider,
      (_, state) => state.showErrorToast(context),
    );
    final isLoading = ref.watch(loginControllerProvider).isLoading;
    final tenant = ref.watch(tenantConfigProvider);
    final l10n = context.l10n;

    return AppScaffold(
      maxContentWidth: AppSizes.formMaxWidth,
      body: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              AuthHeader(title: l10n.loginTitle),
              const SizedBox(height: AppSpacing.xxl),
              AppTextField(
                label: l10n.emailLabel,
                hint: l10n.emailHint,
                controller: _emailController,
                validator: Validators.email(l10n),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.username],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPasswordField(
                label: l10n.passwordLabel,
                hint: l10n.passwordHint,
                controller: _passwordController,
                validator: Validators.required(l10n),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AppButton.text(
                  label: l10n.forgotPasswordLink,
                  onPressed: () => context.go(AppRoutes.forgotPassword),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton.primary(
                label: l10n.loginButton,
                icon: Icons.arrow_forward,
                isLoading: isLoading,
                onPressed: _submit,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthFooterPrompt(
                prompt: l10n.noAccountPrompt(tenant.name),
                actionLabel: l10n.createAccountLink,
                onAction: () => context.go(AppRoutes.signUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
