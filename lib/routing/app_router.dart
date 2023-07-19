import 'package:healthcafe_dashboard/pages/settings_page.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/pages/appointments_page.dart';
import 'package:healthcafe_dashboard/pages/dashboard_page.dart';
import 'package:healthcafe_dashboard/pages/error_page.dart';
import 'package:healthcafe_dashboard/pages/home_page.dart';
import 'package:healthcafe_dashboard/pages/login_page.dart';
import 'package:healthcafe_dashboard/pages/wellness_plan_page.dart';
import 'package:healthcafe_dashboard/pages/users_page.dart';

class AppRouter {
  const AppRouter._();

  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String wellnessPlans = '/wellness-plans';
  static const String appointments = '/appointments';
  static const String users = '/users';
  static const String settings = '/settings';

  static AppPage getPage(PageConfig config) {
    return _routes[config.route]?.call(config.args) ??
        ErrorPage(args: config.args);
  }

  static final Map<String, AppPage Function(Map<String, dynamic>)> _routes = {
    home: (args) => HomePage(args: args),
    login: (args) => LoginPage(args: args),
    dashboard: (args) => DashboardPage(args: args),
    wellnessPlans: (args) => WellnessPlansPage(args: args),
    appointments: (args) => AppointmentsPage(args: args),
    users: (args) => UsersPage(args: args),
    settings: (args) => SettingsPage(args: args),
  };
}
