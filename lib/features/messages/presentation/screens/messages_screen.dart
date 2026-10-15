import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppTabPage(
      eyebrow: l10n.messagesEyebrow,
      title: l10n.messagesTitle,
      child: AppEmptyState(
        icon: Icons.chat_bubble_outline,
        title: l10n.comingSoonTitle,
        message: l10n.comingSoonMessage,
      ),
    );
  }
}
