import 'package:flutter/material.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class AppRouterInfoParser extends RouteInformationParser<PageConfig> {
  @override
  Future<PageConfig> parseRouteInformationWithDependencies(
    RouteInformation routeInformation,
    BuildContext context,
  ) async {
    final String? path = routeInformation.location;
    return PageConfig(location: path);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path.toString());
  }
}
