import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/scr/users/users_screen.dart';

class UsersPage extends AppPage {
  const UsersPage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const UsersScreen();
  }
}
