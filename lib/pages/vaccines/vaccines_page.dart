import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class VaccinesPage extends AppPage {
  const VaccinesPage({required super.state});

  @override
  Widget build(BuildContext context) {
    return const VaccinesScreen();
  }

}

class VaccinesScreen extends StatefulWidget {
  const VaccinesScreen({super.key});

  @override
  State<VaccinesScreen> createState() => _State();
}

class _State extends State<VaccinesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Vaccines Page'),
      ),
    );
  }
}