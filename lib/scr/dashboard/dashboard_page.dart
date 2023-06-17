import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/scr/dashboard/dashboard_screen.dart';

class DashboardPage extends AppPage {
  const DashboardPage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreen();
  }
}
