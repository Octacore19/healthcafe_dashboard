import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/nav_stack.dart';
import 'package:healthcafe_dashboard/blocs/home_router_cubit.dart';
import 'package:healthcafe_dashboard/routing/home_router_delegate.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/routing/router_cubit.dart';

class HomePage extends AppPage {
  const HomePage({required super.args});

  @override
  Widget build(BuildContext context) {
    final location = args['location'] ?? AppRouter.dashboard;
    return BlocProvider(
      create: (context) => HomeRouterCubit(location),
      child: BlocListener<RouterCubit, NavStack>(
        listener: (context, state) {
          print('New config: $state');
          // context.read<HomeRouterCubit>().onPageChanged(2);
        },
        child: BlocBuilder<HomeRouterCubit, NavStack>(
          builder: (context, state) {
            final parent = Router.of(context).backButtonDispatcher;
            BackButtonDispatcher? childDispatcher;
            if (parent != null) {
              childDispatcher = ChildBackButtonDispatcher(parent);
            }
            childDispatcher?.takePriority();
            return Router(
              backButtonDispatcher: childDispatcher,
              routerDelegate: HomeRouterDelegate(),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.notifyListeners,
    required this.navKey,
    super.key,
  });

  final VoidCallback notifyListeners;
  final GlobalKey<NavigatorState>? navKey;

  @override
  State<HomeScreen> createState() => _State();
}

class _State extends State<HomeScreen> {
  late final HomeRouterCubit _routerCubit;
  late final RouterCubit _appCubit;

  final pages = [
    PageConfig(location: AppRouter.dashboard, name: 'Dashboard'),
    PageConfig(location: AppRouter.users, name: 'Users'),
    PageConfig(location: AppRouter.appointments, name: 'Appointments'),
    PageConfig(location: AppRouter.wellnessPlans, name: 'Wellness Plans'),
    PageConfig(location: AppRouter.settings, name: 'Settings'),
  ];

  @override
  void initState() {
    _routerCubit = BlocProvider.of(context);
    _appCubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeRouterCubit, NavStack>(
        builder: (context, stack) {
          return SafeArea(
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.175,
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
                            child: buildItems(context, stack.last),
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

  Widget buildItems(BuildContext context, PageConfig? page) {
    return ListView.separated(
      itemCount: pages.length,
      separatorBuilder: (_, __) => SizedBox(height: 24.h),
      itemBuilder: (context, index) {
        bool current = page?.route == pages[index].route;

        return ListTile(
          onTap: () => _appCubit.push(pages[index].route),
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
          title: Text(pages[index].name ?? ''),
        );
      },
    );
  }
}
