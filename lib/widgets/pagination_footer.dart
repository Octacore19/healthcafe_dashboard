import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Textbutton(
            onTap: () {},
            fgColor: ColorName.grey50,
            child: Row(
              children: [
                Icon(Icons.arrow_back, size: 16.r),
                SizedBox(width: 6.w),
                Text(
                  'Prev',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                splashRadius: 24.r,
                visualDensity: VisualDensity.compact,
                icon: const Text('1'),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 24.r,
                visualDensity: VisualDensity.compact,
                icon: const Text('2'),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 24.r,
                visualDensity: VisualDensity.compact,
                icon: const Text('5'),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 24.r,
                visualDensity: VisualDensity.compact,
                icon: const Text('6'),
              ),
            ],
          ),
          Textbutton(
            onTap: () {},
            fgColor: ColorName.grey50,
            child: Row(
              children: [
                Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(Icons.arrow_forward, size: 16.r),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
