import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/repos/auth_repo.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';
import 'package:healthcafe_dashboard/pages/error_page.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/auth_router.dart';
import 'package:healthcafe_dashboard/routing/home_router.dart';

final appRoutes = GoRouter(
  debugLogDiagnostics: kDebugMode,
  navigatorKey: rootNavKey,
  initialLocation: '/',
  redirect: (context, state) {
    final repo = RepositoryProvider.of<UserRepo>(context);
    final user = repo.currentUser;
    if (user == null || user.id.isEmpty) {
      return '/login';
    }
    return null;
  },
  routes: [
    authRoute,
    homeRoute,
  ],
  errorPageBuilder: (context, state) => ErrorPage(state: state),
);
