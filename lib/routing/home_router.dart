import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';
import 'package:healthcafe_dashboard/pages/appointments/appointment_detail_page.dart';
import 'package:healthcafe_dashboard/pages/appointments/appointments_page.dart';
import 'package:healthcafe_dashboard/pages/dashboard/dashboard_page.dart';
import 'package:healthcafe_dashboard/pages/home_screen.dart';
import 'package:healthcafe_dashboard/pages/settings/settings_page.dart';
import 'package:healthcafe_dashboard/pages/upload_test_page.dart';
import 'package:healthcafe_dashboard/pages/user_profile/user_profile_page.dart';
import 'package:healthcafe_dashboard/pages/users/users_page.dart';
import 'package:healthcafe_dashboard/pages/wellness_plans/wellness_plan_page.dart';

final homeRoute = StatefulShellRoute.indexedStack(
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => DashboardPage(
            state: state,
            key: state.pageKey,
          ),
          redirect: (context, state) {
            final repo = RepositoryProvider.of<UserRepo>(context);
            final user = repo.currentUser;
            if (user == null || user.id.isEmpty) {
              return '/login';
            }
            return null;
          },
        ),
      ],
    ),
    StatefulShellBranch(routes: [
      GoRoute(
        path: '/users',
        pageBuilder: (context, state) => UsersPage(
          state: state,
          key: state.pageKey,
        ),
        redirect: (context, state) {
          final repo = RepositoryProvider.of<UserRepo>(context);
          final user = repo.currentUser;
          if (user == null || user.id.isEmpty) {
            return '/login';
          }
          return null;
        },
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
        redirect: (context, state) {
          final repo = RepositoryProvider.of<UserRepo>(context);
          final user = repo.currentUser;
          if (user == null || user.id.isEmpty) {
            return '/login';
          }
          return null;
        },
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
        redirect: (context, state) {
          final repo = RepositoryProvider.of<UserRepo>(context);
          final user = repo.currentUser;
          if (user == null || user.id.isEmpty) {
            return '/login';
          }
          return null;
        },
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => SettingsPage(
          state: state,
          key: state.pageKey,
        ),
        redirect: (context, state) {
          final repo = RepositoryProvider.of<UserRepo>(context);
          final user = repo.currentUser;
          if (user == null || user.id.isEmpty) {
            return '/login';
          }
          return null;
        },
      ),
    ])
  ],
  builder: (context, state, navShell) => HomeScreen(navShell: navShell),
);
