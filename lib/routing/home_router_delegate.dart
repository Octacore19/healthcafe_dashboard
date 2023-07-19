import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/pages/home_page.dart';
import 'package:healthcafe_dashboard/res/keys.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
class HomeRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      notifyListeners: notifyListeners,
      navKey: navigatorKey,
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => AppKeys.homeShellKey;

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
  }
}
