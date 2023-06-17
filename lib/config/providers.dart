import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/app.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service_impl.dart';

class AppProviders {
  static get providers {
    return [
      RepositoryProvider<AuthService>(create: (_) => AuthServiceImpl(App.env)),
      /* RepositoryProvider<UserRepo>(
        create: (_) => UserRepoImpl(
          App.auth,
          App.db,
          App.pref,
          App.storage,
        ),
      ),
      RepositoryProvider<AuthRepo>(
        create: (context) {
          final authService = RepositoryProvider.of<AuthService>(context);
          return AuthRepoImpl(
            App.auth,
            authService,
            App.pref,
            App.storage,
            App.db,
          );
        },
      ),
      RepositoryProvider<ReportsRepo>(create: (_) => ReportsRepoImpl(App.db)),
      RepositoryProvider<WellnessRepo>(create: (_) => WellnessRepoImpl(App.db)),
      RepositoryProvider<PlanRepo>(create: (_) => PlanRepoImpl(App.db)),
      RepositoryProvider<TestRepo>(create: (_) => TestRepoImpl(App.db)),
      RepositoryProvider<AppointmentRepo>(
        create: (_) => AppointmentRepoImpl(App.db),
      ), */
    ];
  }
}
