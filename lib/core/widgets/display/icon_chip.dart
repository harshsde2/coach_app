import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

/// Brand-tinted rounded square holding an icon.
class IconChip extends StatelessWidget {
  const IconChip({required this.icon, this.size = 40, super.key});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.brandSubtle,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(icon, color: colors.brand, size: size * 0.45),
    );
  }
}

/// Small uppercase pill on brand colour ("CONFIRMED").
class AppBadge extends StatelessWidget {
  const AppBadge(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.brand,
        borderRadius: AppRadius.badge,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs + 1,
        ),
        child: Text(text.toUpperCase(), style: context.textStyles.badge),
      ),
    );
  }
}
