import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/nav_stack.dart';
import 'package:healthcafe_dashboard/routing/router_cubit.dart';
import 'package:healthcafe_dashboard/scr/home/home_router_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.notifyListeners,
    required this.navKey,
    required this.returnCubit,
    super.key,
  });

  final VoidCallback notifyListeners;
  final GlobalKey<NavigatorState>? navKey;
  final Function(HomeRouterCubit) returnCubit;

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  late final HomeRouterCubit _routerCubit;
  late final RouterCubit _appCubit;

  final items = ['Overview', 'Test', 'Appointments', 'Users'];

  @override
  void initState() {
    _routerCubit = BlocProvider.of(context);
    _appCubit = BlocProvider.of(context);
    super.initState();

    widget.returnCubit(_routerCubit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeRouterCubit, NavStack>(
        builder: (context, stack) {
          int currentIndex = 0;
          switch (stack.last?.route) {
            case AppRouter.dashboard:
              currentIndex = 0;
              break;
            case AppRouter.test:
              currentIndex = 1;
              break;
            case AppRouter.appointments:
              currentIndex = 2;
              break;
            case AppRouter.users:
              currentIndex = 3;
              break;
          }
          return SafeArea(
            child: Row(
              children: [
                SizedBox(
                  height: 1.sh,
                  width: 0.175.sw,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.primary500,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(36, 24, 36, 24).r,
                          height: 0.15.sh,
                          child: const Image(
                            image: AssetImage(AppImages.dashboardLogo),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            type: MaterialType.transparency,
                            child: buildItems(context, currentIndex),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Navigator(
                    key: widget.navKey,
                    observers: [HeroController()],
                    pages: stack.pages,
                    onPopPage: _onPopPage,
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) => widget.notifyListeners(),
      ),
    );
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (_routerCubit.canPop()) {
      _routerCubit.pop();
      return true;
    } else {
      _appCubit.pop();
      return false;
    }
  }

  Widget buildItems(BuildContext context, int currentIndex) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 24.h),
      itemBuilder: (context, index) {
        bool current = currentIndex == index;
        return ListTile(
          onTap: () => _routerCubit.onPageChanged(index),
          selected: current,
          textColor: Colors.white,
          selectedColor: AppColors.primary500,
          selectedTileColor: Colors.white,
          leading: SvgPicture.asset(
            AppSvgs.threeLayersIcon,
            colorFilter: current
                ? const ColorFilter.mode(AppColors.primary500, BlendMode.srcIn)
                : null,
          ),
          title: Text(items[index]),
        );
      },
    );
  }
}
