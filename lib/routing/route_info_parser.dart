import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class AppRouterInfoParser extends RouteInformationParser<PageConfig> {
  @override
  Future<PageConfig> parseRouteInformationWithDependencies(
    RouteInformation routeInformation,
    BuildContext context,
  ) async {
    String? path = AppRouter.login;
    try {
      final repo = RepositoryProvider.of<UserRepo>(context);
      final user = await repo.authUser.first;
      debugPrint('Auth state => $user');
      if (user != null) {
        path = routeInformation.location;
      }
    } catch (e) {
      debugPrint('Error => $e');
    }
    debugPrint('Path: $path');
    return PageConfig(location: path);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path.toString());
  }
}
