import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/app.dart';
import 'package:healthcafe_dashboard/auth_cubit.dart';
import 'package:healthcafe_dashboard/data/repos/wellness_plan.dart';
import 'package:healthcafe_dashboard/domain/repos/wellness_plan.dart';
import 'package:healthcafe_dashboard/res/theme.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/data/repos/appointment.dart';
import 'package:healthcafe_dashboard/data/repos/auth.dart';
import 'package:healthcafe_dashboard/data/repos/user.dart';
import 'package:healthcafe_dashboard/domain/repos/appointment.dart';
import 'package:healthcafe_dashboard/domain/repos/auth.dart';
import 'package:healthcafe_dashboard/domain/repos/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await App.init();
  final app = MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthService>(create: (_) => AuthService(App.env)),
      RepositoryProvider<AuthRepo>(
        create: (context) => IAuthRepo(
          service: RepositoryProvider.of(context),
          firebaseAuth: App.auth,
          firebaseFirestore: App.db,
        ),
      ),
      RepositoryProvider<UserRepo>(
        create: (context) => IUserRepo(firestore: App.db),
      ),
      RepositoryProvider<AppointmentRepo>(
        create: (context) => IAppointmentRepo(
          firebaseFirestore: App.db,
        ),
      ),
      RepositoryProvider<WellnessPlanRepo>(
        create: (context) => IWellnessPlanRepo(firestore: App.db),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            RepositoryProvider.of(context),
          ),
        ),
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
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      designSize: const Size(1440, 1024),
      builder: (context, child) => MaterialApp.router(
        title: App.env.name,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: kDebugMode,
        routerConfig: appRoutes,
      ),
    );
  }
}
