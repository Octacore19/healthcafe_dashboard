import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class WellnessPlansPage extends AppPage {
  const WellnessPlansPage({
    required super.args,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const WellnessPlanScreen();
  }
}

class WellnessPlanScreen extends StatefulWidget {
  const WellnessPlanScreen({super.key});

  @override
  State<WellnessPlanScreen> createState() => _State();
}

class _State extends State<WellnessPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Wellness Plans Page'),
      ),
    );
  }
}
