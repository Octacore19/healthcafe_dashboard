import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/pages/error_page.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/auth_router.dart';
import 'package:healthcafe_dashboard/routing/home_router.dart';

final appRoutes = GoRouter(
  debugLogDiagnostics: kDebugMode,
  navigatorKey: rootNavKey,
  observers: [HeroController()],
  initialLocation: '/',
  routes: [
    authRoute,
    homeRoute,
  ],
  errorPageBuilder: (context, state) => ErrorPage(state: state),
);
