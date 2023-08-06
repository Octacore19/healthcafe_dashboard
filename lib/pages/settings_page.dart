import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class SettingsPage extends AppPage {
  const SettingsPage({
    required super.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen();
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _State();
}

class _State extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
