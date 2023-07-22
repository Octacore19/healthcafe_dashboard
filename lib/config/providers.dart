import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/app.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/data/remote/repos/auth_repo.dart';
import 'package:healthcafe_dashboard/domain/repos/auth_repo.dart';

class AppProviders {
  static get providers {
    return [
      RepositoryProvider<AuthService>(create: (_) => AuthService(App.env)),
      RepositoryProvider<AuthRepo>(
        create: (context) => AuthRepoImpl(
          service: RepositoryProvider.of(context),
          firebaseAuth: App.auth,
          firestore: App.db,
        ),
      )
    ];
  }
}
