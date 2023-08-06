import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/models/homepage.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.navShell, super.key});

  final StatefulNavigationShell navShell;

  List<HomePages> get pages => [
        HomePages.dashboard,
        HomePages.users,
        HomePages.appointments,
        HomePages.wellness,
        HomePages.settings,
      ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final extended = width > 1258;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30).h,
              child:
                  SvgPicture.asset(extended ? AppSvgs.logoText : AppSvgs.logo),
            ),
            backgroundColor: AppColors.primary700,
            destinations: pages
                .mapIndexed(
                  (i, e) => NavigationRailDestination(
                    icon: SvgPicture.asset(e.icon),
                    label: Text(e.title),
                  ),
                )
                .toList(),
            selectedIndex: navShell.currentIndex,
            selectedLabelTextStyle: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: AppColors.primary25,
            ),
            unselectedLabelTextStyle: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: AppColors.primary25,
            ),
            extended: extended,
            useIndicator: true,
            indicatorColor: AppColors.primary500,
            onDestinationSelected: (index) {
              navShell.goBranch(
                index,
                initialLocation: index == navShell.currentIndex,
              );
            },
          ),
          Expanded(child: navShell)
        ],
      ),
    );
  }
}
