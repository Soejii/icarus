import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/app/bottom_navigation_shell.dart';
import 'package:gaia/features/activity/presentation/screen/activity_screen.dart';
import 'package:gaia/features/announcement/presentation/screens/detail_announcement_screen.dart';
import 'package:gaia/features/announcement/presentation/screens/list_announcement_screen.dart';
import 'package:gaia/features/discussion/presentation/screen/choose_discussion_screen.dart';
import 'package:gaia/features/discussion/presentation/screen/class_discussion_screen.dart';
import 'package:gaia/features/attendance/presentation/screens/attedance_screen.dart';
import 'package:gaia/features/discussion/presentation/screen/create_discussion_screen.dart';
import 'package:gaia/features/discussion/presentation/screen/detail_discussion_screen.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/screens/balance_screen.dart';
import 'package:gaia/features/balances/presentation/screens/balance_history_screen.dart';
import 'package:gaia/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:gaia/features/chat/presentation/screens/chat_contact_picker_screen.dart';
import 'package:gaia/features/chat/presentation/screens/chat_detail_screen.dart';
import 'package:gaia/features/discussion/presentation/types/create_discussion_args.dart';
import 'package:gaia/features/edutainment/presentation/screens/detail_edutainment_screen.dart';
import 'package:gaia/features/edutainment/presentation/screens/list_edutainment_screen.dart';
import 'package:gaia/features/home/presentation/home_screen.dart';
import 'package:gaia/features/lainnya/presentation/screens/lainnya_screen.dart';
import 'package:gaia/features/login/presentation/screen/login_screen.dart';
import 'package:gaia/features/notifications/presentation/screen/notification_screen.dart';
import 'package:gaia/features/profile/presentation/screens/profile_screen.dart';
import 'package:gaia/features/profile/presentation/screens/account_information_screen.dart';
import 'package:gaia/features/profile/presentation/screens/change_password_screen.dart';
import 'package:gaia/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:gaia/features/school/presentation/screens/school_information_screen.dart';
import 'package:gaia/features/subject/presentation/screens/detail_sub_module_screen.dart';
import 'package:gaia/features/subject/presentation/screens/subject_picker_screen.dart';
import 'package:gaia/features/subject/presentation/screens/detail_subject_screen.dart';
import 'package:gaia/features/task/presentation/screens/collect_task_screen.dart';
import 'package:gaia/features/task/presentation/screens/detail_task_screen.dart';
import 'package:gaia/shared/core/infrastructure/analytics/analytics_providers.dart';
import 'package:gaia/shared/core/infrastructure/analytics/analytics_tracker.dart';
import 'package:gaia/shared/core/infrastructure/auth/auth_state_provider.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:gaia/shared/screens/error_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
GoRouter appRouter(Ref ref) {
  final authAsync = ref.watch(authStateProvider);
  final analytics = ref.watch(analyticsTrackerProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    redirect: (context, state) {
      if (authAsync.isLoading) return null;
      if (authAsync.hasError) return '/login';

      final loggedIn = authAsync.value == AuthStatus.authenticated;
      final atLogin = state.matchedLocation == '/login';

      if (!loggedIn && !atLogin) return '/login';
      if (loggedIn && atLogin) return '/home';
      return null;
    },
    observers: [_GoRouterAnalyticsObserver(analytics)],
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => BottomNavigationShell(shell: shell),
        branches: [
          // HOME BRANCH
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: RouteName.home,
                pageBuilder: (_, __) => const MaterialPage(child: HomeScreen()),
                routes: [
                  GoRoute(
                    path: 'list-announcements',
                    name: RouteName.listAnnouncement,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ListAnnouncementScreen(),
                  ),
                  GoRoute(
                    path: 'announcements/:id',
                    name: RouteName.detailAnnouncement,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final id = state.pathParameters['id']!;
                      return DetailAnnouncementScreen(
                        id: int.parse(id),
                      );
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: 'list-edutaiment',
                    name: RouteName.listEdutainment,
                    builder: (context, state) => const ListEdutainmentScreen(),
                  ),
                  GoRoute(
                    path: 'edutainment/:id',
                    name: RouteName.detailEdutainment,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final id = state.pathParameters['id']!;
                      return DetailEdutainmentScreen(
                        id: int.parse(id),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'schedule',
                    name: RouteName.schedule,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ScheduleScreen(),
                  ),
                  GoRoute(
                    path: 'subject-picker',
                    name: RouteName.subjectPicker,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const SubjectPickerScreen(),
                    routes: [
                      GoRoute(
                        path: 'detail-subject/:id',
                        name: RouteName.detailSubject,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (_, state) {
                          final id = state.pathParameters['id']!;
                          final initialTab =
                              state.uri.queryParameters['initial_tab'];
                          return DetailSubjectScreen(
                            idSubject: int.parse(id),
                            initialTab: initialTab == null
                                ? null
                                : int.tryParse(initialTab),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'detail-sub-module/:id',
                        name: RouteName.detailSubModule,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (_, state) {
                          final id = state.pathParameters['id']!;
                          return DetailSubModuleScreen(
                            idSubModule: int.parse(id),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'lainnya',
                        name: RouteName.lainnya,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (_, __) => const LainnyaScreen(),
                      ),
                      GoRoute(
                        path: 'notification',
                        name: RouteName.notification,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (_, __) => const NotificationScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'choose-discussion',
                    name: RouteName.chooseDiscussion,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ChooseDiscussionScreen(),
                    routes: [
                      GoRoute(
                        path: 'class-discussion',
                        name: RouteName.classDiscussion,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (_, state) {
                          return const ClassDiscussionScreen();
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'detail-discussion/:id',
                    name: RouteName.detailDiscussion,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final id = state.pathParameters['id']!;
                      return DetailDiscussionScreen(
                        idDiscussion: int.parse(id),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'create-discussion',
                    name: RouteName.createDiscussion,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final args = state.extra as CreateDiscussionArgs;
                      return CreateDiscussionScreen(
                        type: args,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'attendance',
                    name: RouteName.attendance,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const AttendanceScreen(),
                  ),
                  GoRoute(
                    path: 'balance',
                    name: RouteName.balance,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const BalanceScreen(),
                    routes: [
                      GoRoute(
                        path: 'balance-history',
                        name: RouteName.balanceHistory,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (_, state) {
                          final type =
                              state.uri.queryParameters['type'] == 'savings'
                                  ? BalanceType.savings
                                  : BalanceType.emoney;
                          return BalanceHistoryScreen(type: type);
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: 'detail-task/:id',
                    name: RouteName.detailTask,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return DetailTaskScreen(idTask: int.parse(id));
                    },
                    routes: [
                      GoRoute(
                        path: 'collect-task',
                        name: RouteName.collectTask,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return CollectTaskScreen(idTask: int.parse(id));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ACTIVITY BRANCH
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/activity',
                name: RouteName.activity,
                pageBuilder: (_, __) =>
                    const MaterialPage(child: ActivityScreen()),
              ),
            ],
          ),

          // CHAT BRANCH
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                name: RouteName.chat,
                pageBuilder: (_, __) => const MaterialPage(child: ChatScreen()),
                routes: [
                  GoRoute(
                    path: 'contact-picker',
                    name: RouteName.contactPicker,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ChatContactPickerScreen(),
                  ),
                  GoRoute(
                    path: 'detail-chat/:userId',
                    name: RouteName.chatDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final userId = state.pathParameters['userId']!;
                      return ChatDetailScreen(
                        userId: int.parse(userId),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // PROFILE BRANCH
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: '/profile',
                  name: RouteName.profile,
                  pageBuilder: (_, __) =>
                      const MaterialPage(child: ProfileScreen()),
                  routes: [
                    GoRoute(
                      path: 'school-information',
                      name: RouteName.schoolInformation,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const SchoolInformationScreen(),
                    ),
                    GoRoute(
                      path: 'account-information',
                      name: RouteName.accountInformation,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const AccountInformationScreen(),
                    ),
                    GoRoute(
                      path: 'change-password',
                      name: RouteName.changePassword,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const ChangePasswordScreen(),
                    ),
                  ]),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (_, __) => const LoginScreen(),
      ),
    ],
    errorBuilder: (_, state) =>
        ErrorScreen(error: state.error ?? Exception('Unknown router error')),
    debugLogDiagnostics: kDebugMode,
  );
}

class _GoRouterAnalyticsObserver extends NavigatorObserver {
  _GoRouterAnalyticsObserver(this._analytics);
  final AnalyticsTracker _analytics;

  void _log(Route<dynamic>? route) {
    final name = route?.settings.name;
    if (name == null || name.isEmpty) return;
    _analytics.trackScreen(name);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _log(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      _log(newRoute);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _log(previousRoute);
}
