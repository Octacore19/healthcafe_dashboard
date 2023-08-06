import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/res/app_icons.dart';
import 'package:healthcafe_dashboard/res/colors.dart';

class LabelledTextField extends StatelessWidget {
  const LabelledTextField({
    required this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.suffix,
    this.inputType,
    this.toggleVisibility,
    this.width = double.maxFinite,
    this.obscureText = false,
    this.showSuffix = false,
    super.key,
  });

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final String? initialValue;
  final double width;
  final bool obscureText;
  final bool showSuffix;
  final Widget? suffix;
  final TextInputType? inputType;
  final Function(bool)? toggleVisibility;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.grey700,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            obscureText: obscureText,
            obscuringCharacter: '*',
            initialValue: initialValue,
            controller: controller,
            keyboardType: inputType,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.grey700,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
              ),
              suffix: showSuffix ? getSuffix() : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget getSuffix() {
    Widget child = InkWell(
      onTap: () => toggleVisibility?.call(!obscureText),
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(4).r,
        child: Icon(
          obscureText ? AppIcons.visibility : AppIcons.visibilityOff,
          size: 16.r,
        ),
      ),
    );
    if (suffix != null) {
      child = InkWell(
        onTap: () => toggleVisibility?.call(!obscureText),
        customBorder: const CircleBorder(),
        child: suffix!,
      );
    }
    return child;
  }
}
