import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/bottom_navigation_shell.dart';
import 'package:icarus/features/announcement/presentation/screens/detail_announcement_screen.dart';
import 'package:icarus/features/announcement/presentation/screens/list_announcement_screen.dart';
import 'package:icarus/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:icarus/features/chat/presentation/screens/chat_contact_picker_screen.dart';
import 'package:icarus/features/chat/presentation/screens/chat_detail_screen.dart';
import 'package:icarus/features/edutainment/presentation/screens/detail_edutainment_screen.dart';
import 'package:icarus/features/edutainment/presentation/screens/list_edutainment_screen.dart';
import 'package:icarus/features/home/presentation/home_screen.dart';
import 'package:icarus/features/lainnya/presentation/screens/lainnya_screen.dart';
import 'package:icarus/features/login/presentation/screen/login_screen.dart';
import 'package:icarus/features/notifications/presentation/screen/notification_screen.dart';
import 'package:icarus/features/profile/presentation/screens/profile_screen.dart';
import 'package:icarus/features/profile/presentation/screens/account_information_screen.dart';
import 'package:icarus/features/profile/presentation/screens/change_password_screen.dart';
import 'package:icarus/features/school/presentation/screens/school_information_screen.dart';
import 'package:icarus/shared/core/infrastructure/analytics/analytics_providers.dart';
import 'package:icarus/shared/core/infrastructure/analytics/analytics_tracker.dart';
import 'package:icarus/shared/core/infrastructure/auth/auth_state_provider.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/screens/error_screen.dart';
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
