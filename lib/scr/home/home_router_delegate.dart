import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/res/keys.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/scr/home/home_router_cubit.dart';
import 'package:healthcafe_dashboard/scr/home/home_screen.dart';

class HomeRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  HomeRouterCubit? _routerCubit;

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      notifyListeners: notifyListeners,
      navKey: navigatorKey,
      returnCubit: (value) {
        _routerCubit = value;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => AppKeys.homeShellKey;

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
    _routerCubit?.push(configuration.route, configuration.args);
  }

  @override
  PageConfig? get currentConfiguration => _routerCubit?.state.last;
}
