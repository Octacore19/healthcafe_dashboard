import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/pages/forgot_password_page.dart';
import 'package:healthcafe_dashboard/pages/login_page.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/router_cubit.dart';

class AuthRouterCubit extends Cubit<int> {
  AuthRouterCubit({
    required int page,
    required RouterCubit routerCubit,
  })  : _routerCubit = routerCubit,
        super(page){
    _streamSubscription = routerCubit.stream.listen((route) {
      final args = route.last?.args;
      int newPage = args?['page'] ?? 0;
      emit(newPage);
    });
  }

  final pages = {
    'Login': const LoginPage(args: {}),
    'Forgot Password': const ForgotPasswordPage(args: {}),
  };

  final RouterCubit _routerCubit;

  StreamSubscription? _streamSubscription;

  bool canPop() {
    _routerCubit.pop();
    return false;
  }

  void onPageChanged(int page) {
    final paths = [
      AppRouter.login,
      AppRouter.forgetPassword,
    ];
    _routerCubit.push(paths[page]);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
