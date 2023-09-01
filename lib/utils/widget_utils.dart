import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/gen/fonts.gen.dart';

void showSuccessSnackBar({
  required BuildContext context,
  required String message,
  VoidCallback? onVisible,
}) {
  final style = TextStyle(
    color: ColorName.success700,
    fontFamily: FontFamily.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  final textSize = textWidgetSize(message, style);

  final bar = SnackBar(
    backgroundColor: ColorName.success50,
    width: textSize.width * 1.5,
    content: Text(message, style: style, textAlign: TextAlign.center),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: ColorName.success500),
    ),
    onVisible: onVisible,
  );
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(bar);
}

void showWarningSnackBar({
  required BuildContext context,
  required String message,
  VoidCallback? onVisible,
}) {
  final style = TextStyle(
    color: ColorName.warning700,
    fontFamily: FontFamily.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  final textSize = textWidgetSize(message, style);

  final bar = SnackBar(
    backgroundColor: ColorName.warning50,
    width: textSize.width * 1.5,
    content: Text(message, style: style, textAlign: TextAlign.center),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: ColorName.warning500),
    ),
    onVisible: onVisible,
  );
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(bar);
}

void showErrorSnackBar({
  required BuildContext context,
  required String message,
  VoidCallback? onVisible,
}) {
  final textSize = textWidgetSize(
    message,
    const TextStyle(color: Colors.white),
  );

  final bar = SnackBar(
    backgroundColor: ColorName.danger500.withOpacity(0.1),
    width: textSize.width * 1.5,
    content: Text(
      message,
      style: TextStyle(
        color: ColorName.danger500,
        fontFamily: FontFamily.poppins,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: ColorName.danger500.withOpacity(0.3),
      ),
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
