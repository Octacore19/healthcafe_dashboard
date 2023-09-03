import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/gen/fonts.gen.dart';
import 'package:healthcafe_dashboard/res/app_icons.dart';

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
    this.multiline = false,
    this.minLine = 1,
    this.autofill,
    this.formatters,
    this.textCapitalization = TextCapitalization.none,
    this.onSubmit,
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
  final bool multiline;
  final int minLine;
  final List<String>? autofill;
  final List<TextInputFormatter>? formatters;
  final TextCapitalization textCapitalization;
  final Function(String?)? onSubmit;

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
              color: ColorName.gray700,
              fontFamily: FontFamily.inter,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            obscureText: obscureText,
            obscuringCharacter: '*',
            initialValue: initialValue,
            controller: controller,
            keyboardType: inputType,
            minLines: minLine,
            maxLines: multiline ? null : 1,
            autofillHints: autofill,
            inputFormatters: formatters,
            textCapitalization: textCapitalization,
            onFieldSubmitted: onSubmit,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: ColorName.gray500,
            ),
            cursorColor: ColorName.gray300,
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: ColorName.gray500.withOpacity(0.3),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: const BorderSide(color: ColorName.gray300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: const BorderSide(color: ColorName.gray300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: const BorderSide(color: ColorName.gray300),
              ),
              suffixIcon: showSuffix ? getSuffix() : null,
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
