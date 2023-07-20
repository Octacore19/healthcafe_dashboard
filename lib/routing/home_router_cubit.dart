import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/pages/appointments_page.dart';
import 'package:healthcafe_dashboard/pages/dashboard_page.dart';
import 'package:healthcafe_dashboard/pages/settings_page.dart';
import 'package:healthcafe_dashboard/pages/users_page.dart';
import 'package:healthcafe_dashboard/pages/wellness_plan_page.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/router_cubit.dart';

class HomeRouterCubit extends Cubit<int> {
  HomeRouterCubit({
    required int page,
    required RouterCubit routerCubit,
  })  : _routerCubit = routerCubit,
        super(page) {
    _streamSubscription = routerCubit.stream.listen((route) {
      final args = route.last?.args;
      int newPage = args?['page'] ?? 0;
      emit(newPage);
    });
  }

  final pages = {
    'Dashboard': const DashboardPage(args: {}),
    'Users': const UsersPage(args: {}),
    'Appointments': const AppointmentsPage(args: {}),
    'Wellness Plans': const WellnessPlansPage(args: {}),
    'Settings': const SettingsPage(args: {}),
  };

  final RouterCubit _routerCubit;

  StreamSubscription? _streamSubscription;

  bool canPop() {
    _routerCubit.pop();
    return false;
  }

  void onPageChanged(int page) {
    final paths = [
      AppRouter.home,
      AppRouter.users,
      AppRouter.appointments,
      AppRouter.wellnessPlans,
      AppRouter.settings,
    ];
    _routerCubit.push(paths[page]);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
