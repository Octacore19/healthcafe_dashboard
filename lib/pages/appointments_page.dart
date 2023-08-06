import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class AppointmentsPage extends AppPage {
  const AppointmentsPage({
    required super.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AppointmentsScreen();
  }
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Appointments Page'),
      ),
    );
  }
}
