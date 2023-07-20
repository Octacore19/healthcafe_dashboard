import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/auth_router_cubit.dart';
import 'package:healthcafe_dashboard/routing/auth_router_delegate.dart';

import '../res/colors.dart';

class AuthPage extends AppPage {
  const AuthPage({required super.args});

  @override
  Widget build(BuildContext context) {
    final page = args['page'] ?? 0;

    final parent = Router.of(context).backButtonDispatcher;
    BackButtonDispatcher? childDispatcher;
    if (parent != null) {
      childDispatcher = ChildBackButtonDispatcher(parent);
    }
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthRouterCubit(
          page: page,
          routerCubit: BlocProvider.of(context),
        ),
        child: BlocBuilder<AuthRouterCubit, int>(
          builder: (context, state) => Row(
            children: [
              SizedBox(
                width: 0.5.sw,
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: AppColors.primary600),
                  child: Image(
                    image: const AssetImage(AppImages.loginFrameImg),
                    height: 1.sh,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                width: 0.5.sw,
                child: Router(
                  backButtonDispatcher: childDispatcher,
                  routerDelegate: AuthRouterDelegate(
                    BlocProvider.of<AuthRouterCubit>(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
