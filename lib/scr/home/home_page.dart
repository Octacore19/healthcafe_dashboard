import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/nav_stack.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';
import 'package:healthcafe_dashboard/scr/home/home_router_cubit.dart';
import 'package:healthcafe_dashboard/scr/home/home_router_delegate.dart';

class HomePage extends AppPage {
  const HomePage({required super.args});

  @override
  Widget build(BuildContext context) {
    final page = args['page'] ?? 0;
    String location = AppRouter.dashboard;
    switch (page) {
      case 1:
        location = AppRouter.test;
        break;
      case 2:
        location = AppRouter.appointments;
        break;
      case 3:
        location = AppRouter.users;
        break;
    }
    return BlocProvider(
      create: (context) => HomeRouterCubit([
        PageConfig(location: location),
      ]),
      child: BlocBuilder<HomeRouterCubit, NavStack>(
        builder: (context, state) {
          final parent = Router.of(context).backButtonDispatcher;
          BackButtonDispatcher? childDispatcher;
          if (parent != null) {
            childDispatcher = ChildBackButtonDispatcher(parent);
          }
          return Router(
            backButtonDispatcher: childDispatcher,
            routerDelegate: HomeRouterDelegate(),
          );
        },
      ),
    );
  }
}
