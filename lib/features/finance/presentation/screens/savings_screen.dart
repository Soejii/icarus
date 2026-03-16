import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/finance/presentation/widgets/savings_balance_header_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_history_list_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Tabungan',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          const SavingsBalanceHeaderWidget(),
          Expanded(
            child: TransactionHistoryListWidget(
              onViewAll: () => context.pushNamed(RouteName.viewAllHistory),
            ),
          ),
        ],
      ),
    );
  }
}
