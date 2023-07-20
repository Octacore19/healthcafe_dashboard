import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/routing/nav_stack.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/routing/router_cubit.dart';

class AppRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  AppRouterDelegate(this._cubit);

  final RouterCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouterCubit, NavStack>(
      listener: (context, state) => notifyListeners(),
      builder: (context, stack) => Navigator(
        key: navigatorKey,
        observers: [HeroController()],
        pages: stack.pages,
        onPopPage: _onPopPage,
      ),
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
    _cubit.push(configuration.path.path, configuration.args);
  }


  @override
  PageConfig? get currentConfiguration => _cubit.state.last;

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (_cubit.canPop()) {
      _cubit.pop();
      return true;
    } else {
      return false;
    }
  }
}