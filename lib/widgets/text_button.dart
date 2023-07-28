import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Textbutton extends StatelessWidget {
  const Textbutton({
    required this.onTap,
    this.inProgress = false,
    this.label = '',
    this.width = 0,
    this.bgColor,
    this.fgColor,
    this.padding,
    this.textStyle,
    this.density,
    this.minimumSize,
    this.child,
    this.border,
    this.borderRadius,
    super.key,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final bool inProgress;
  final String label;
  final double width;
  final Color? bgColor;
  final Color? fgColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final VisualDensity? density;
  final Size? minimumSize;
  final BorderSide? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget child = this.child ?? Text(label);
    if (inProgress) {
      child = SizedBox(
        height: 24.h,
        width: 24.h,
        child: const CircularProgressIndicator.adaptive(),
      );
    }
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: inProgress ? bgColor?.withOpacity(0.5) : bgColor,
        foregroundColor: fgColor,
        textStyle: textStyle ??
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
        padding: padding,
        visualDensity: density,
        minimumSize: minimumSize,
        side: border,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8).r,
        ),
      ),
      child: child,
    );
  }
}
