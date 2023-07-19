import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class UsersPage extends AppPage {
  const UsersPage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const UsersScreen();
  }
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Users Page'),),
    );
  }
}