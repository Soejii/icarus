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
import 'package:icarus/features/performance/presentation/screens/performance_screen.dart';
import 'package:icarus/features/profile/presentation/screens/profile_screen.dart';
import 'package:icarus/features/profile/presentation/screens/account_information_screen.dart';
import 'package:icarus/features/profile/presentation/screens/change_password_screen.dart';
import 'package:icarus/features/finance/presentation/screens/bill_payment_detail_screen.dart';
import 'package:icarus/features/finance/presentation/screens/canteen_payment_screen.dart';
import 'package:icarus/features/finance/presentation/screens/emoney_screen.dart';
import 'package:icarus/features/finance/presentation/screens/finance_screen.dart';
import 'package:icarus/features/finance/presentation/screens/nominal_entry_screen.dart';
import 'package:icarus/features/finance/presentation/screens/payment_gateway_screen.dart';
import 'package:icarus/features/finance/presentation/screens/pending_confirmation_screen.dart';
import 'package:icarus/features/finance/presentation/screens/savings_screen.dart';
import 'package:icarus/features/finance/presentation/screens/school_bills_screen.dart';
import 'package:icarus/features/finance/presentation/screens/select_payment_screen.dart';
import 'package:icarus/features/finance/presentation/screens/transaction_success_screen.dart';
import 'package:icarus/features/finance/presentation/screens/view_all_history_screen.dart';
import 'package:icarus/features/finance/presentation/screens/detail_tagihan_screen.dart';
import 'package:icarus/features/finance/presentation/screens/detail_pembayaran_screen.dart';
import 'package:icarus/features/finance/presentation/screens/pilih_metode_keuangan_screen.dart';
import 'package:icarus/features/finance/presentation/screens/multi_select_payment_screen.dart';
import 'package:icarus/features/finance/presentation/screens/bank_transfer_payment_screen.dart';
import 'package:icarus/features/finance/presentation/screens/va_payment_screen.dart';
import 'package:icarus/features/finance/domain/types/va_bank_type.dart';
import 'package:icarus/features/absence_letter/presentation/screens/absence_letter_screen.dart';
import 'package:icarus/features/absence_letter/presentation/screens/edit_absence_letter_screen.dart';
import 'package:icarus/features/edit_personal_info/presentation/screens/change_history_screen.dart';
import 'package:icarus/features/edit_personal_info/presentation/screens/edit_personal_info_screen.dart';
import 'package:icarus/features/edit_child_info/presentation/screens/child_account_info_screen.dart';
import 'package:icarus/features/edit_child_info/presentation/screens/child_change_history_screen.dart';
import 'package:icarus/features/edit_child_info/presentation/screens/edit_child_info_screen.dart';
import 'package:icarus/features/edit_child_info/presentation/screens/child_detail_screen.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/features/child/presentation/screens/child_selection_screen.dart';
import 'package:icarus/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:icarus/features/school/presentation/screens/school_information_screen.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/screens/tahfidz_tahsin_screen.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/features/konseling/presentation/screens/list_konseling_screen.dart';
import 'package:icarus/features/konseling/presentation/screens/detail_konseling_screen.dart';
import 'package:icarus/features/pusat_unduh/presentation/screens/pusat_unduh_screen.dart';
import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/features/sentra/presentation/screens/list_sentra_screen.dart';
import 'package:icarus/features/sentra/presentation/screens/detail_sentra_screen.dart';
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
                    path: 'konseling',
                    name: RouteName.konseling,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ListKonselingScreen(),
                  ),
                  GoRoute(
                    path: 'konseling/:id',
                    name: RouteName.konselingDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final id = int.parse(state.pathParameters['id']!);
                      final type = state.extra! as KonselingType;
                      return DetailKonselingScreen(id: id, type: type);
                    },
                  ),
                  GoRoute(
                    path: 'pusat-unduh',
                    name: RouteName.pusatUnduh,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const PusatUnduhScreen(),
                  ),
                  GoRoute(
                    path: 'sentra',
                    name: RouteName.sentra,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ListSentraScreen(),
                  ),
                  GoRoute(
                    path: 'sentra/:id',
                    name: RouteName.sentraDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final entity = state.extra! as SentraEntity;
                      return DetailSentraScreen(entity: entity);
                    },
                  ),
                  GoRoute(
                    path: 'notification',
                    name: RouteName.notification,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const NotificationScreen(),
                  ),
                  // Finance routes
                  GoRoute(
                    path: 'finance',
                    name: RouteName.finance,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const FinanceScreen(),
                  ),
                  GoRoute(
                    path: 'school-bills',
                    name: RouteName.schoolBills,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const SchoolBillsScreen(),
                  ),
                  GoRoute(
                    path: 'savings',
                    name: RouteName.savings,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const SavingsScreen(),
                  ),
                  GoRoute(
                    path: 'emoney',
                    name: RouteName.emoney,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const EmoneyScreen(),
                  ),
                  GoRoute(
                    path: 'view-all-history',
                    name: RouteName.viewAllHistory,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ViewAllHistoryScreen(),
                  ),
                  GoRoute(
                    path: 'nominal-entry',
                    name: RouteName.nominalEntry,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const NominalEntryScreen(),
                  ),
                  GoRoute(
                    path: 'bill-payment-detail',
                    name: RouteName.billPaymentDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const BillPaymentDetailScreen(),
                  ),
                  GoRoute(
                    path: 'select-payment',
                    name: RouteName.selectPayment,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const SelectPaymentScreen(),
                  ),
                  GoRoute(
                    path: 'payment-gateway',
                    name: RouteName.paymentGateway,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const PaymentGatewayScreen(),
                  ),
                  GoRoute(
                    path: 'pending-confirmation',
                    name: RouteName.pendingConfirmation,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const PendingConfirmationScreen(),
                  ),
                  GoRoute(
                    path: 'transaction-success',
                    name: RouteName.transactionSuccess,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const TransactionSuccessScreen(),
                  ),
                  GoRoute(
                    path: 'canteen-payment',
                    name: RouteName.canteenPayment,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const CanteenPaymentScreen(),
                  ),
                  GoRoute(
                    path: 'detail-tagihan',
                    name: RouteName.detailTagihan,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const DetailTagihanScreen(),
                  ),
                  GoRoute(
                    path: 'detail-pembayaran',
                    name: RouteName.detailPembayaran,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const DetailPembayaranScreen(),
                  ),
                  GoRoute(
                    path: 'pilih-metode-keuangan',
                    name: RouteName.pilihMetodeKeuangan,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const PilihMetodeKeuanganScreen(),
                  ),
                  GoRoute(
                    path: 'multi-select-payment',
                    name: RouteName.multiSelectPayment,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const MultiSelectPaymentScreen(),
                  ),
                  GoRoute(
                    path: 'bank-transfer-payment',
                    name: RouteName.bankTransferPayment,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const BankTransferPaymentScreen(),
                  ),
                  GoRoute(
                    path: 'va-payment',
                    name: RouteName.vaPayment,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, state) {
                      final bankType =
                          state.extra as VaBankType? ?? VaBankType.bmi;
                      return VaPaymentScreen(bankType: bankType);
                    },
                  ),
                  // Tahfidz Tahsin
                  GoRoute(
                    path: 'tahfidz-tahsin',
                    name: RouteName.tahfidzTahsin,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const TahfidzTahsinScreen(),
                  ),
                  // Schedule
                  GoRoute(
                    path: 'schedule',
                    name: RouteName.schedule,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ScheduleScreen(),
                  ),
                  // Child selector
                  GoRoute(
                    path: 'pilih-anak-didik',
                    name: RouteName.pilihAnakDidik,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const ChildSelectionScreen(),
                  ),
                  // Absence Letter
                  GoRoute(
                    path: 'absence-letter',
                    name: RouteName.absenceLetter,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const AbsenceLetterScreen(),
                  ),
                  GoRoute(
                    path: 'edit-absence-letter',
                    name: RouteName.editAbsenceLetter,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, __) => const EditAbsenceLetterScreen(),
                  ),
                ],
              ),
            ],
          ),

          // PERFORMANCE BRANCH
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/performance',
                name: RouteName.performance,
                pageBuilder: (_, __) =>
                    const MaterialPage(child: PerformanceScreen()),
                // routes: [],
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
                    GoRoute(
                      path: 'change-history',
                      name: RouteName.changeHistory,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const ChangeHistoryScreen(),
                    ),
                    GoRoute(
                      path: 'edit-personal-info',
                      name: RouteName.editPersonalInfo,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const EditPersonalInfoScreen(),
                    ),
                    GoRoute(
                      path: 'child-account-info',
                      name: RouteName.childAccountInfo,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const ChildAccountInfoScreen(),
                    ),
                    GoRoute(
                      path: 'child-change-history',
                      name: RouteName.childChangeHistory,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const ChildChangeHistoryScreen(),
                    ),
                    GoRoute(
                      path: 'edit-child-info',
                      name: RouteName.editChildInfo,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const EditChildInfoScreen(),
                    ),
                    GoRoute(
                      path: 'child-detail',
                      name: RouteName.childDetail,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, state) => ChildDetailScreen(
                        child: state.extra! as ChildEntity,
                      ),
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
