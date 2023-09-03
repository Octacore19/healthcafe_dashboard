import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/gen/fonts.gen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.child, super.key});

  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Settings',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                color: ColorName.grey900,
                fontFamily: FontFamily.inter,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12).r,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32).r,
                  child: Row(
                    children: [
                      NavigationRail(
                        destinations: [
                          NavigationRailDestination(
                            icon: Assets.img.profileCircle.svg(),
                            label: const Text('Profile'),
                          ),
                          NavigationRailDestination(
                            icon: Assets.img.profile2user.svg(),
                            label: const Text('Team'),
                          ),
                        ],
                        useIndicator: true,
                        extended: true,
                        labelType: NavigationRailLabelType.none,
                        minExtendedWidth: 0.1.sw,
                        indicatorColor: ColorName.primary25,
                        selectedIndex: child.currentIndex,
                        selectedLabelTextStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: ColorName.primary500,
                        ),
                        unselectedLabelTextStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: ColorName.grey400,
                        ),
                        onDestinationSelected: (index) {
                          child.goBranch(
                            index,
                            initialLocation: index == child.currentIndex,
                          );
                        },
                      ),
                      VerticalDivider(
                        color: ColorName.grey200,
                        width: 64.w,
                        thickness: 1.w,
                      ),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
