import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class AssessmentsPage extends AppPage {
  const AssessmentsPage({required super.state});

  @override
  Widget build(BuildContext context) {
    return const AssessmentsScreen();
  }

}

class AssessmentsScreen extends StatefulWidget {
  const AssessmentsScreen({super.key});

  @override
  State<AssessmentsScreen> createState() => _State();
}

class _State extends State<AssessmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Assessments Page'),
      ),
    );
  }
}