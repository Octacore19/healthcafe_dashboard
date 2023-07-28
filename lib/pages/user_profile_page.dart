import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class UserProfilePage extends AppPage {
  const UserProfilePage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const UserProfileScreen();
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}
