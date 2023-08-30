import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';

class SearchFilterView extends StatelessWidget {
  const SearchFilterView({
    required this.onFromTapped,
    required this.onToTapped,
    this.onFilterTapped,
    this.controller,
    this.showFilter = false,
    super.key,
  });

  final TextEditingController? controller;
  final VoidCallback onFromTapped;
  final VoidCallback onToTapped;
  final VoidCallback? onFilterTapped;
  final bool showFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: SvgPicture.asset(AppSvgs.search),
              prefixIconConstraints: BoxConstraints(
                maxHeight: 20.h,
                minWidth: 40.w,
              ),
              hintText: 'Search',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.grey500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: const BorderSide(color: AppColors.grey300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: const BorderSide(color: AppColors.grey300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: const BorderSide(color: AppColors.grey300),
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        buildFilterItem(
          onTap: onFromTapped,
          title: 'Jan 6, 2022',
          label: 'From:',
          icon: AppSvgs.calendarTick,
        ),
        SizedBox(width: 12.w),
        buildFilterItem(
          onTap: onToTapped,
          title: 'Jan 6, 2022',
          label: 'To:',
          icon: AppSvgs.calendarTick,
        ),
        if (showFilter) ...[
          SizedBox(width: 12.w),
          buildFilterItem(
            onTap: onFilterTapped,
            title: 'Filter',
            icon: AppSvgs.sort,
          ),
        ]
      ],
    );
  }

  Widget buildFilterItem({
    required String title,
    required VoidCallback? onTap,
    String? label,
    String? icon,
  }) {
    return Row(
      children: [
        if (label != null) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.grey600,
            ),
          ),
          SizedBox(width: 10.w),
        ],
        Textbutton(
          onTap: onTap,
          border: const BorderSide(
            color: AppColors.grey300,
          ),
          density: VisualDensity.standard,
          fgColor: AppColors.grey700,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10).r,
          child: icon != null
              ? Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              : Text(title),
        )
      ],
    );
  }
}
