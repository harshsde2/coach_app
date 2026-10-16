import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BrandMark(size: 56),
            SizedBox(height: AppSpacing.xxl),
            AppLoader(),
          ],
        ),
      ),
    );
  }
}
