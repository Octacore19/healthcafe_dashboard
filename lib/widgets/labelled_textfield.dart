import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelledTextField extends StatelessWidget {
  const LabelledTextField({
    required this.label,
    this.hint,
    this.initialValue,
    this.controller,
    super.key,
  });

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          initialValue: initialValue,
          controller: controller,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
