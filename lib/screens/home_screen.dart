import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/models/homepage.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.navShell, super.key});

  final StatefulNavigationShell navShell;

  List<HomePages> get pages => [
        HomePages.dashboard,
        HomePages.users,
        HomePages.appointments,
        HomePages.wellness,
        HomePages.vaccines,
        HomePages.assessments,
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
              child: buildIcon(extended),
            ),
            backgroundColor: ColorName.primary700,
            destinations: pages
                .mapIndexed(
                  (i, e) => NavigationRailDestination(
                    icon: e.icon.svg(),
                    label: Text(e.title),
                  ),
                )
                .toList(),
            selectedIndex: navShell.currentIndex,
            selectedLabelTextStyle: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: ColorName.primary25,
            ),
            unselectedLabelTextStyle: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: ColorName.primary25,
            ),
            extended: extended,
            useIndicator: true,
            indicatorColor: ColorName.primary500,
            onDestinationSelected: (index) {
              navShell.goBranch(
                index,
                initialLocation: index == navShell.currentIndex,
              );
            },
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20).w,
                    child: IconButton(
                      onPressed: () {},
                      icon: Assets.img.notificationIcon.svg(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30).w,
                    child: IconButton(
                      onPressed: () {},
                      icon: FadeInImage.assetNetwork(
                        placeholder: Assets.img.loading.path,
                        image: 'https://www.google.com',
                        imageErrorBuilder: (_, __, stack) => Image(
                          image: Assets.img.profilePlaceholder.provider(),
                          height: 24.h,
                          width: 24.w,
                        ),
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  ),
                ],
              ),
              body: navShell,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIcon(bool expanded) {
    if (expanded) {
      return Row(
        children: [
          Assets.img.primevivaLogo.svg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.img.primevivaText.svg(),
              Assets.img.healthcareText.svg(),
            ],
          ),
        ],
      );
    }
    return Assets.img.primevivaLogo.svg();
  }
}
