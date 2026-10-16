import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/widgets/layout/section_heading.dart';
import 'package:flutter/material.dart';

class AppTabPage extends StatelessWidget {
  const AppTabPage({
    required this.title,
    required this.child,
    this.eyebrow,
    this.trailing,
    super.key,
  });

  final String title;
  final String? eyebrow;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            sliver: SliverToBoxAdapter(
              child: SectionHeading(
                eyebrow: eyebrow,
                title: title,
                trailing: trailing,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              0,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            sliver: SliverFillRemaining(hasScrollBody: false, child: child),
          ),
        ],
      ),
    );
  }
}
