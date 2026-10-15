import 'package:coach_app/core/constants/app_constants.dart';
import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:coach_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    final l10n = context.l10n;
    final confirmed = await showAppConfirmDialog(
      context,
      title: l10n.logoutConfirmTitle,
      message: l10n.logoutConfirmMessage,
      confirmLabel: l10n.logoutButton,
    );
    if (!confirmed || !mounted) return;

    setState(() => _isLoggingOut = true);
    // The router redirects to login once the auth state changes.
    await ref.read(authControllerProvider.notifier).logout();
    if (mounted) setState(() => _isLoggingOut = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final l10n = context.l10n;
    final colors = context.colors;
    final textStyles = context.textStyles;

    return AppTabPage(
      eyebrow: l10n.profileEyebrow,
      title: l10n.profileTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Row(
              children: [
                AppAvatar(initials: user?.initials ?? '', size: 64),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.fullName ?? '', style: textStyles.titleSmall),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        user?.email ?? '',
                        style: textStyles.body.copyWith(
                          color: colors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(height: AppSpacing.xl),
          AppButton.outline(
            label: l10n.logoutButton,
            icon: Icons.logout,
            isLoading: _isLoggingOut,
            onPressed: _logout,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text.rich(
            TextSpan(
              text: '${l10n.poweredBy} ',
              children: [
                TextSpan(
                  text: AppConstants.platformName,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style: textStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
