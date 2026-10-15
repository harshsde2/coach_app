import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppTabPage(
      eyebrow: l10n.contactsEyebrow,
      title: l10n.contactsTitle,
      child: AppEmptyState(
        icon: Icons.people_outline,
        title: l10n.comingSoonTitle,
        message: l10n.comingSoonMessage,
      ),
    );
  }
}
