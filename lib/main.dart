import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/app.dart';
import 'package:healthcafe_dashboard/bloc/auth_bloc.dart';
import 'package:healthcafe_dashboard/config/providers.dart';
import 'package:healthcafe_dashboard/res/theme.dart';
import 'package:healthcafe_dashboard/routing/route_info_parser.dart';
import 'package:healthcafe_dashboard/routing/router_cubit.dart';
import 'package:healthcafe_dashboard/routing/router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await App.init();
  final app = MultiRepositoryProvider(
    providers: AppProviders.providers,
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            RepositoryProvider.of(context),
          ),
        ),
        BlocProvider(create: (_) => RouterCubit(App.configs)),
      ],
      child: const MyApp(),
    ),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder: (context, child) => MaterialApp.router(
        title: App.env.name,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routerDelegate: AppRouterDelegate(BlocProvider.of(context)),
        routeInformationParser: AppRouterInfoParser(),
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
