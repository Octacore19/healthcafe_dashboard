import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/repos/auth.dart';
import 'package:healthcafe_dashboard/pages/appointments/appointment_detail_page.dart';
import 'package:healthcafe_dashboard/pages/appointments/appointments_page.dart';
import 'package:healthcafe_dashboard/pages/assessments/assessments_page.dart';
import 'package:healthcafe_dashboard/pages/assessments/manage_assessments.dart';
import 'package:healthcafe_dashboard/pages/dashboard/dashboard_page.dart';
import 'package:healthcafe_dashboard/pages/profile/profile_page.dart';
import 'package:healthcafe_dashboard/pages/team/team_page.dart';
import 'package:healthcafe_dashboard/screens/home_screen.dart';
import 'package:healthcafe_dashboard/pages/appointments/upload_test_page.dart';
import 'package:healthcafe_dashboard/pages/user_profile/user_profile_page.dart';
import 'package:healthcafe_dashboard/pages/users/users_page.dart';
import 'package:healthcafe_dashboard/pages/vaccines/manage_vaccine_page.dart';
import 'package:healthcafe_dashboard/pages/vaccines/vaccines_page.dart';
import 'package:healthcafe_dashboard/pages/wellness_plans/manage_plan_page.dart';
import 'package:healthcafe_dashboard/pages/wellness_plans/wellness_plan_page.dart';
import 'package:healthcafe_dashboard/screens/settings_screen.dart';

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
            final repo = RepositoryProvider.of<AuthRepo>(context);
            final user = repo.currentUser;
            debugPrint('User: $user');
            if (user == null || user.id.isEmpty) {
              return '/login';
            }
            return null;
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/users',
          pageBuilder: (context, state) => UsersPage(
            state: state,
            key: state.pageKey,
          ),
          redirect: (context, state) {
            final repo = RepositoryProvider.of<AuthRepo>(context);
            final user = repo.currentUser;
            if (user == null || user.id.isEmpty) {
              return '/login';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'detail/:id',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return UserProfilePage(state: state);
              },
            )
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/appointments',
          pageBuilder: (context, state) => AppointmentsPage(
            state: state,
            key: state.pageKey,
          ),
          redirect: (context, state) {
            final repo = RepositoryProvider.of<AuthRepo>(context);
            final user = repo.currentUser;
            if (user == null || user.id.isEmpty) {
              return '/login';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'detail/:id',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return AppointmentDetailPage(state: state);
              },
              routes: [
                GoRoute(
                  path: 'result',
                  redirect: (context, state) {
                    final repo = RepositoryProvider.of<AuthRepo>(context);
                    final user = repo.currentUser;
                    if (user == null || user.id.isEmpty) {
                      return '/login';
                    }
                    return null;
                  },
                  pageBuilder: (context, state) {
                    return UploadTestPage(state: state);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/wellness',
          pageBuilder: (context, state) => WellnessPlansPage(
            state: state,
            key: state.pageKey,
          ),
          redirect: (context, state) {
            final repo = RepositoryProvider.of<AuthRepo>(context);
            final user = repo.currentUser;
            if (user == null || user.id.isEmpty) {
              return '/login';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'plan',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return ManagePlanPage(state: state);
              },
            ),
            GoRoute(
              path: 'plan/:id',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return ManagePlanPage(state: state);
              },
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/vaccines',
          pageBuilder: (context, state) => VaccinesPage(
            state: state,
            key: state.pageKey,
          ),
          redirect: (context, state) {
            final repo = RepositoryProvider.of<AuthRepo>(context);
            final user = repo.currentUser;
            if (user == null || user.id.isEmpty) {
              return '/login';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'vaccine',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return ManageVaccinePage(state: state);
              },
            ),
            GoRoute(
              path: 'vaccine/:id',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return ManageVaccinePage(state: state);
              },
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/assessments',
          pageBuilder: (context, state) => AssessmentsPage(
            state: state,
            key: state.pageKey,
          ),
          redirect: (context, state) {
            final repo = RepositoryProvider.of<AuthRepo>(context);
            final user = repo.currentUser;
            if (user == null || user.id.isEmpty) {
              return '/login';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'assessment',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return ManageAssessmentsPage(state: state);
              },
            ),
            GoRoute(
              path: 'assessment/:id',
              redirect: (context, state) {
                final repo = RepositoryProvider.of<AuthRepo>(context);
                final user = repo.currentUser;
                if (user == null || user.id.isEmpty) {
                  return '/login';
                }
                return null;
              },
              pageBuilder: (context, state) {
                return ManageAssessmentsPage(state: state);
              },
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        StatefulShellRoute.indexedStack(branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) => ProfilePage(
                  state: state,
                  key: state.pageKey,
                ),
                redirect: (context, state) {
                  final repo = RepositoryProvider.of<AuthRepo>(context);
                  final user = repo.currentUser;
                  if (user == null || user.id.isEmpty) {
                    return '/login';
                  }
                  return null;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/team',
                pageBuilder: (context, state) => TeamPage(
                  state: state,
                  key: state.pageKey,
                ),
                redirect: (context, state) {
                  final repo = RepositoryProvider.of<AuthRepo>(context);
                  final user = repo.currentUser;
                  if (user == null || user.id.isEmpty) {
                    return '/login';
                  }
                  return null;
                },
              ),
            ],
          ),
        ], builder: (context, state, shell) => SettingsScreen(child: shell)),
      ],
    ),
    /*StatefulShellBranch(
      routes: [
        ShellRoute(
          navigatorKey: settingsNavKey,
          builder: (context, state, child) => SettingsScreen(child: child),
          routes: [
          ],
        ),
      ],
    ),*/
  ],
  builder: (context, state, navShell) => HomeScreen(navShell: navShell),
);
