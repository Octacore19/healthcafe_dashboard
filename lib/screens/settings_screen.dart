import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
