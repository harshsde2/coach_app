import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Standard screen frame: safe area, screen padding, optional scrolling,
/// tap-outside-to-dismiss-keyboard, and a back button when the route can pop.
///
/// Use [maxContentWidth] for forms so they stay readable on tablets.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.scrollable = true,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.screen,
      AppSpacing.md,
      AppSpacing.screen,
      AppSpacing.xl,
    ),
    this.maxContentWidth,
    this.showBackButton = true,
    super.key,
  });

  final Widget body;
  final bool scrollable;
  final EdgeInsetsGeometry padding;
  final double? maxContentWidth;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final canPop = showBackButton && (ModalRoute.of(context)?.canPop ?? false);

    Widget content = Padding(padding: padding, child: body);
    if (maxContentWidth != null) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth!),
          child: content,
        ),
      );
    }
    if (scrollable) {
      content = SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: content,
      );
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: canPop ? AppBar() : null,
        body: SafeArea(top: !canPop, child: content),
      ),
    );
  }
}
