import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class ProfilePage extends AppPage {
  const ProfilePage({required super.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const _Screen();
  }
}

class _Screen extends StatefulWidget {
  const _Screen({Key? key}) : super(key: key);

  @override
  State<_Screen> createState() => _State();
}

class _State extends State<_Screen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
