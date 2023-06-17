import 'package:flutter/material.dart';

class AppKeys {
  const AppKeys._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _homeShellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static GlobalKey<NavigatorState> get rootKey => _rootNavigatorKey;

  static GlobalKey<NavigatorState> get homeShellKey => _homeShellNavigatorKey;
}
