import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/scr/test/test_screen.dart';

class TestPage extends AppPage {
  const TestPage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const TestScreen();
  }
}
