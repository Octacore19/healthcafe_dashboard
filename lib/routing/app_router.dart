import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/scr/appointments/appointments_page.dart';
import 'package:healthcafe_dashboard/scr/dashboard/dashboard_page.dart';
import 'package:healthcafe_dashboard/scr/error_page.dart';
import 'package:healthcafe_dashboard/scr/home/home_page.dart';
import 'package:healthcafe_dashboard/scr/login/login_page.dart';
import 'package:healthcafe_dashboard/scr/test/test_page.dart';
import 'package:healthcafe_dashboard/scr/users/users_page.dart';

class AppRouter {
  const AppRouter._();

  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String test = '/test';
  static const String appointments = '/appointments';
  static const String users = '/users';

  static AppPage getPage(PageConfig config) {
    return _routes[config.route]?.call(config.args) ??
        ErrorPage(args: config.args);
  }

  static final Map<String, AppPage Function(Map<String, dynamic>)> _routes = {
    home: (args) => HomePage(args: args),
    login: (args) => LoginPage(args: args),
    dashboard: (args) => DashboardPage(args: args),
    test: (args) => TestPage(args: args),
    appointments: (args) => AppointmentsPage(args: args),
    users: (args) => UsersPage(args: args),
  };
}
