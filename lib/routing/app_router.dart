import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/pages/error_page.dart';
import 'package:healthcafe_dashboard/pages/home_page.dart';
import 'package:healthcafe_dashboard/pages/login_page.dart';

class AppRouter {
  const AppRouter._();

  static const String home = '/';
  static const String login = '/login';
  static const String wellnessPlans = '/wellness-plans';
  static const String appointments = '/appointments';
  static const String users = '/users';
  static const String settings = '/settings';

  static AppPage getPage(PageConfig config) {
    return _routes[config.path.path]?.call(config.args) ??
        ErrorPage(args: config.args);
  }

  static final Map<String, AppPage Function(Map<String, dynamic>)> _routes = {
    login: (args) => LoginPage(args: args),
    home: (args) {
      args['page'] = 0;
      return HomePage(args: args, key: const ValueKey('home'));
    },
    wellnessPlans: (args) {
      args['page'] = 3;
      return HomePage(args: args, key: const ValueKey('home'));
    },
    appointments: (args) {
      args['page'] = 2;
      return HomePage(args: args, key: const ValueKey('home'));
    },
    users: (args) {
      args['page'] = 1;
      return HomePage(args: args, key: const ValueKey('home'));
    },
    settings: (args) {
      args['page'] = 4;
      return HomePage(args: args, key: const ValueKey('home'));
    },
  };
}
