import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcafe_dashboard/bloc/auth_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/homepage.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/home_router_cubit.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class HomeRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  HomeRouterDelegate(this._routerCubit);

  final HomeRouterCubit _routerCubit;

  Map<HomePages, AppPage<dynamic>> get pages => _routerCubit.pages;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.user;
        return Scaffold(
          backgroundColor: AppColors.grey50,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            shadowColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppSvgs.notificationIcon),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.name ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey700,
                    ),
                  ),
                  Text(
                    user?.email ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey50,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 24.w),
            ],
          ),
          body: BlocConsumer<HomeRouterCubit, int>(
            builder: (context, stack) {
              return Navigator(
                key: navigatorKey,
                observers: [HeroController()],
                pages: [pages.values.toList()[stack]],
                onPopPage: _onPopPage,
              );
            },
            listener: (context, state) => notifyListeners(),
          ),
        );
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {}

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    return _routerCubit.canPop();
  }
}
