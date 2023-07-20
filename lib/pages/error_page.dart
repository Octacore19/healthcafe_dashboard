import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class ErrorPage extends AppPage {
  const ErrorPage({required super.args, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('This is Error Page')),
    );
  }
}
