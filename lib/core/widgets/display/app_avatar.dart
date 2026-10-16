import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.initials,
    this.size = AppSizes.avatarSm,
    super.key,
  });

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.avatar,
        borderRadius: BorderRadius.circular(size * 0.29),
      ),
      child: Text(
        initials,
        style: context.textStyles.titleSmall.copyWith(
          color: colors.brand,
          fontSize: size * 0.34,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
