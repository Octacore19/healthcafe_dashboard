import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/bloc/auth_bloc.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class AppRouterInfoParser extends RouteInformationParser<PageConfig> {
  @override
  Future<PageConfig> parseRouteInformationWithDependencies(
    RouteInformation routeInformation,
    BuildContext context,
  ) async {
    String? path = AppRouter.login;
    final auth = BlocProvider.of<AuthBloc>(context);
    final state = auth.state;
    if (state is AuthenticatedState) {
      path = routeInformation.location;
    }
    return PageConfig(location: path);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path.toString());
  }
}
