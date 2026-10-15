import 'dart:ui';

import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppNavItem {
  const AppNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// Frosted bottom tab bar with a brand indicator on the active tab.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.navigationBar,
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: AppSizes.bottomNavHeight,
              child: Row(
                children: [
                  for (final (index, item) in items.indexed)
                    Expanded(
                      child: _NavButton(
                        item: item,
                        isActive: index == currentIndex,
                        onTap: () => onTap(index),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final AppNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = isActive ? colors.textPrimary : colors.textTertiary;

    return Semantics(
      selected: isActive,
      button: true,
      label: item.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 36,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isActive ? 22 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: colors.brand,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive ? item.activeIcon : item.icon,
                  size: AppSizes.iconMd,
                  color: isActive ? colors.brand : color,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  item.label,
                  style: context.textStyles.bodySmall.copyWith(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
