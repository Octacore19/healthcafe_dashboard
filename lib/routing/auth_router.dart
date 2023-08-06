import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/pages/forgot_password_page.dart';
import 'package:healthcafe_dashboard/pages/login_page.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';

final authRoute = ShellRoute(
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => LoginPage(
        state: state,
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/forgot-password',
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
            decoration: const BoxDecoration(color: AppColors.primary600),
            child: Image(
              image: const AssetImage(AppImages.loginFrameImg),
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
