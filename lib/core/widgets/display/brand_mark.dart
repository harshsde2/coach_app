import 'package:coach_app/core/config/tenant_config.dart';
import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandMark extends ConsumerWidget {
  const BrandMark({
    this.size = AppSizes.brandMark,
    this.showName = true,
    super.key,
  });

  final double size;
  final bool showName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenant = ref.watch(tenantConfigProvider);
    final colors = context.colors;
    final headingStyle = context.textStyles.titleSmall;

    return Semantics(
      label: tenant.name,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.brand,
              borderRadius: BorderRadius.circular(size * 0.3),
            ),
            child: Text(
              tenant.initial,
              style: headingStyle.copyWith(
                color: colors.onBrand,
                fontSize: size * 0.47,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          if (showName) ...[
            SizedBox(width: size * 0.35),
            Text(
              tenant.name,
              style: headingStyle.copyWith(
                fontSize: size * 0.54,
                fontWeight: FontWeight.w800,
                letterSpacing: size * 0.1,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
