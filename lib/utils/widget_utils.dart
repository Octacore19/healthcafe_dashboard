import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String message,
  VoidCallback? onVisible,
}) {
  final textSize = textWidgetSize(
    message,
    const TextStyle(color: Colors.white),
  );

  final bar = SnackBar(
    width: textSize.width * 1.5,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    onVisible: onVisible,
  );
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(bar);
}

Size textWidgetSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
