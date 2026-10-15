import 'package:coach_app/core/config/tenant_config.dart';
import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Brand mark + "`TENANT` ACCOUNT" eyebrow + title, shared by auth screens.
class AuthHeader extends ConsumerWidget {
  const AuthHeader({required this.title, this.subtitle, super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenant = ref.watch(tenantConfigProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BrandMark(),
        const SizedBox(height: AppSpacing.xxxl),
        SectionHeading(
          eyebrow: context.l10n.accountEyebrow(tenant.name),
          title: title,
          subtitle: subtitle,
          size: SectionHeadingSize.page,
        ),
      ],
    );
  }
}
