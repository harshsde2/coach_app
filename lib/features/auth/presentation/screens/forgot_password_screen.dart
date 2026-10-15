import 'package:coach_app/core/constants/app_durations.dart';
import 'package:coach_app/core/router/app_routes.dart';
import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/async_value_ui.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:coach_app/features/auth/presentation/providers/forgot_password_controller.dart';
import 'package:coach_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:coach_app/features/auth/presentation/widgets/reset_code_step.dart';
import 'package:coach_app/features/auth/presentation/widgets/reset_email_step.dart';
import 'package:coach_app/features/auth/presentation/widgets/reset_password_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(forgotPasswordControllerProvider, (previous, next) {
      final failure = next.failure;
      if (failure != null && !identical(failure, previous?.failure)) {
        context.showFailureToast(failure);
      }
      if (next.step == ForgotPasswordStep.completed &&
          previous?.step != ForgotPasswordStep.completed) {
        context
          ..showToast(
            context.l10n.passwordResetSuccess,
            type: ToastType.success,
          )
          ..go(AppRoutes.login);
      }
    });

    final state = ref.watch(forgotPasswordControllerProvider);
    final controller = ref.read(forgotPasswordControllerProvider.notifier);
    final l10n = context.l10n;

    final subtitle = switch (state.step) {
      ForgotPasswordStep.email => l10n.forgotPasswordSubtitle,
      ForgotPasswordStep.code => l10n.otpSentMessage(state.email),
      ForgotPasswordStep.newPassword ||
      ForgotPasswordStep.completed => l10n.newPasswordSubtitle,
    };

    return AppScaffold(
      maxContentWidth: AppSizes.formMaxWidth,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthHeader(title: l10n.forgotPasswordTitle, subtitle: subtitle),
          const SizedBox(height: AppSpacing.xxl),
          AnimatedSwitcher(
            duration: AppDurations.medium,
            child: switch (state.step) {
              ForgotPasswordStep.email => ResetEmailStep(
                key: const ValueKey(ForgotPasswordStep.email),
                initialEmail: state.email,
                isSubmitting: state.isSubmitting,
                onSubmit: controller.requestCode,
              ),
              ForgotPasswordStep.code => ResetCodeStep(
                key: const ValueKey(ForgotPasswordStep.code),
                isSubmitting: state.isSubmitting,
                onSubmit: controller.verifyCode,
                onChangeEmail: controller.editEmail,
                onResend: () async {
                  final sent = await controller.resendCode();
                  if (sent && context.mounted) {
                    context.showToast(l10n.codeResent, type: ToastType.success);
                  }
                },
              ),
              ForgotPasswordStep.newPassword ||
              ForgotPasswordStep.completed => ResetPasswordStep(
                key: const ValueKey(ForgotPasswordStep.newPassword),
                isSubmitting: state.isSubmitting,
                onSubmit: controller.resetPassword,
              ),
            },
          ),
        ],
      ),
    );
  }
}
