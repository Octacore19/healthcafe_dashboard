import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class AssessmentsPage extends AppPage {
  const AssessmentsPage({required super.state, super.key});

  @override
  Widget build(BuildContext context) {
    return _Screen(key: super.key);
  }
}

class _Screen extends StatefulWidget {
  const _Screen({super.key});

  @override
  State<_Screen> createState() => _State();
}

class _State extends State<_Screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Assessments Page'),
      ),
    );
  }
}
