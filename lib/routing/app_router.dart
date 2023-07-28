import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/pages/auth_page.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/pages/error_page.dart';
import 'package:healthcafe_dashboard/pages/home_page.dart';

class AppRouter {
  const AppRouter._();

  static const String home = '/';
  static const String login = '/auth/login';
  static const String forgetPassword = '/auth/forgot-password';
  static const String wellnessPlans = '/wellness-plans';
  static const String appointments = '/appointments';
  static const String users = '/users';
  static const String settings = '/settings';

  static AppPage getPage(PageConfig config) {
    return _routes[config.path.path]?.call(config.args) ??
        ErrorPage(args: config.args);
  }

  static final Map<String, AppPage Function(Map<String, dynamic>)> _routes = {
    login: (args) {
      args['page'] = 0;
      return AuthPage(args: args, key: const ValueKey('login'));
    },
    forgetPassword: (args) {
      args['page'] = 1;
      return AuthPage(args: args, key: const ValueKey('forget_password'));
    },
    home: (args) {
      args['page'] = 0;
      return HomePage(args: args, key: const ValueKey('home'));
    },
    wellnessPlans: (args) {
      args['page'] = 3;
      return HomePage(args: args, key: const ValueKey('wellness_plan'));
    },
    appointments: (args) {
      args['page'] = 2;
      return HomePage(args: args, key: const ValueKey('appointments'));
    },
    users: (args) {
      args['page'] = 1;
      return HomePage(args: args, key: const ValueKey('users'));
    },
    settings: (args) {
      args['page'] = 4;
      return HomePage(args: args, key: const ValueKey('settings'));
    },
  };
}
