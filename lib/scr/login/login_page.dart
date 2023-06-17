import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/scr/login/login_screen.dart';

class LoginPage extends AppPage {
  const LoginPage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
