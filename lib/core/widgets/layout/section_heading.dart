import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/display/eyebrow.dart';
import 'package:flutter/material.dart';

enum SectionHeadingSize { page, section }

/// `page` uses the large headline (standalone screens like auth),
/// `section` the standard title (tab screens and sections).
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.trailing,
    this.size = SectionHeadingSize.section,
    super.key,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final Widget? trailing;
  final SectionHeadingSize size;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    final titleStyle = switch (size) {
      SectionHeadingSize.page => textStyles.headline,
      SectionHeadingSize.section => textStyles.title,
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null) ...[
                Eyebrow(eyebrow!),
                const SizedBox(height: AppSpacing.xs),
              ],
              Text(title, style: titleStyle),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle!,
                  style: textStyles.body.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
