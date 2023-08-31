import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/pages/forgot_password_page.dart';
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
  builder: (context, state, child) => Scaffold(
    body: Row(
      children: [
        SizedBox(
          width: 0.5.sw,
          child: DecoratedBox(
            decoration: const BoxDecoration(color: ColorName.primary600),
            child: Assets.img.loginFrameImg.image(
              height: 1.sh,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(
          width: 0.5.sw,
          child: child,
        ),
      ],
    ),
  ),
);
