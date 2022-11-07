import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoText extends ConsumerWidget {
  const InfoText({super.key, required this.text, this.textStyle});
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Text(
      text,
      style: textStyle ?? theme.textTheme.bodyLarge,
    );
  }
}
