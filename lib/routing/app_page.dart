import 'package:flutter/material.dart';

abstract class AppPage<P> extends Page<P> {
  const AppPage({
    required this.args,
    this.fullscreenDialog = false,
  });

  final Map<String, dynamic> args;

  final bool fullscreenDialog;

  Widget build(BuildContext context);

  @override
  Route<P> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      fullscreenDialog: fullscreenDialog,
      builder: (context) => build(context),
    );
  }
}
