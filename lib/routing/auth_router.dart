import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/screens/auth_screen.dart';
import 'package:healthcafe_dashboard/pages/forgot_password/forgot_password_page.dart';
import 'package:healthcafe_dashboard/pages/login/login_page.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

final authRoute = ShellRoute(
  navigatorKey: authNavKey,
  routes: [
    GoRoute(
      path: '/login',
      parentNavigatorKey: authNavKey,
      pageBuilder: (context, state) => LoginPage(
        state: state,
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/forgot-password',
      parentNavigatorKey: authNavKey,
      pageBuilder: (context, state) => ForgotPasswordPage(
        state: state,
        key: state.pageKey,
      ),
    )
  ],
  builder: (context, state, child) => AuthScreen(child: child),
);
