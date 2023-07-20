import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Textbutton extends StatelessWidget {
  const Textbutton({
    required this.onTap,
    this.label = '',
    this.width = 0,
    this.child,
    this.bgColor,
    this.fgColor,
    this.padding,
    this.textStyle,
    this.density,
    this.minimumSize,
    super.key,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final String label;
  final double width;
  final Color? bgColor;
  final Color? fgColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final VisualDensity? density;
  final Size? minimumSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        textStyle: textStyle ??
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
        padding: padding,
        visualDensity: density,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8).r,
        ),
      ),
      child: child ?? Text(label),
    );
  }
}
