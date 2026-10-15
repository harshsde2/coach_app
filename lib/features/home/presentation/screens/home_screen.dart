import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:coach_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return AppTabPage(
      eyebrow: DateFormat('EEEE, d MMMM', locale).format(DateTime.now()),
      title: l10n.greeting(user?.firstName ?? ''),
      child: AppEmptyState(
        icon: Icons.dashboard_outlined,
        title: l10n.comingSoonTitle,
        message: l10n.comingSoonMessage,
      ),
    );
  }
}
