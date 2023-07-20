import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/home_router_cubit.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class HomeRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  HomeRouterDelegate(this._routerCubit);

  final HomeRouterCubit _routerCubit;

  Map<String, AppPage<dynamic>> get pages => _routerCubit.pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
