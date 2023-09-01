import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';

class TitleSubtitleView extends StatelessWidget {
  const TitleSubtitleView({
    required this.title,
    required this.subtitle,
    this.titleSize,
    this.subtitleSize,
    super.key,
  });

  final String title;
  final String subtitle;
  final double? titleSize;
  final double? subtitleSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: (titleSize ?? 36).sp,
            fontWeight: FontWeight.w700,
            color: ColorName.grey900,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: (subtitleSize ?? 18).sp,
            fontWeight: FontWeight.w400,
            color: ColorName.grey700,
          ),
        )
      ],
    );
  }
}
