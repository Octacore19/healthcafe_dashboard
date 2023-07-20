import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/auth_router_cubit.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class AuthRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  AuthRouterDelegate(this._routerCubit);

  final AuthRouterCubit _routerCubit;

  Map<String, AppPage<dynamic>> get pages => _routerCubit.pages;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthRouterCubit, int>(
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

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    return _routerCubit.canPop();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {}
}
