import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {this.color, super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.textStyles.eyebrow.copyWith(color: color),
    );
  }
}
