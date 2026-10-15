import 'package:coach_app/core/config/tenant_config.dart';
import 'package:coach_app/core/router/app_router.dart';
import 'package:coach_app/core/theme/app_theme.dart';
import 'package:coach_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoachApp extends ConsumerWidget {
  const CoachApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenant = ref.watch(tenantConfigProvider);
    return MaterialApp.router(
      title: tenant.name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(tenant),
      darkTheme: AppTheme.dark(tenant),
      themeMode: ref.watch(themeModeControllerProvider),
      routerConfig: ref.watch(appRouterProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
