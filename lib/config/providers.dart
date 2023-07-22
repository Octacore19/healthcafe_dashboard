import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/app.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/data/remote/repos/auth_repo.dart';
import 'package:healthcafe_dashboard/data/remote/repos/user_repo.dart';
import 'package:healthcafe_dashboard/domain/repos/auth_repo.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';

class AppProviders {
  static get providers {
    return [
      RepositoryProvider<AuthService>(create: (_) => AuthService(App.env)),
      RepositoryProvider<AuthRepo>(
        create: (context) => IAuthRepo(
          service: RepositoryProvider.of(context),
          firebaseAuth: App.auth,
        ),
      ),
      RepositoryProvider<UserRepo>(
        create: (context) => IUserRepo(
          firebaseAuth: App.auth,
          firebaseFirestore: App.db,
        ),
      ),
    ];
  }
}
