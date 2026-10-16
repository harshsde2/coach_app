import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({this.size = AppSizes.iconLg, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: size,
        child: const CircularProgressIndicator(strokeWidth: 2.5),
      ),
    );
  }
}
