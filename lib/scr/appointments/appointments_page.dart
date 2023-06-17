import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/scr/appointments/appointments_screen.dart';

class AppointmentsPage extends AppPage {
  const AppointmentsPage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const AppointmentsScreen();
  }
}
