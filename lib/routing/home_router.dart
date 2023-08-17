import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/pages/appointment_detail_page.dart';
import 'package:healthcafe_dashboard/pages/appointments_page.dart';
import 'package:healthcafe_dashboard/pages/dashboard_page.dart';
import 'package:healthcafe_dashboard/pages/home_screen.dart';
import 'package:healthcafe_dashboard/pages/settings_page.dart';
import 'package:healthcafe_dashboard/pages/upload_test_page.dart';
import 'package:healthcafe_dashboard/pages/user_profile_page.dart';
import 'package:healthcafe_dashboard/pages/users_page.dart';
import 'package:healthcafe_dashboard/pages/wellness_plan_page.dart';

final homeRoute = StatefulShellRoute.indexedStack(
  branches: [
    StatefulShellBranch(routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => DashboardPage(
          state: state,
          key: state.pageKey,
        ),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: '/users',
        pageBuilder: (context, state) => UsersPage(
          state: state,
          key: state.pageKey,
        ),
        routes: [
          GoRoute(
            path: 'detail/:id',
            pageBuilder: (context, state) {
              return UserProfilePage(state: state);
            },
          )
        ],
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: '/appointments',
        pageBuilder: (context, state) => AppointmentsPage(
          state: state,
          key: state.pageKey,
        ),
        routes: [
          GoRoute(
            path: 'detail/:id',
            pageBuilder: (context, state) {
              return AppointmentDetailPage(state: state);
            },
            routes: [
              GoRoute(
                path: 'result',
                pageBuilder: (context, state) {
                  return UploadTestPage(state: state);
                },
              ),
            ],
          ),
        ],
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: '/wellness-plans',
        pageBuilder: (context, state) => WellnessPlansPage(
          state: state,
          key: state.pageKey,
        ),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => SettingsPage(
          state: state,
          key: state.pageKey,
        ),
      ),
    ])
  ],
  builder: (context, state, navShell) => HomeScreen(navShell: navShell),
);
