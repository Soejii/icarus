import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/finance/domain/types/transaction_status_type.dart';
import 'package:icarus/features/finance/domain/types/transaction_type.dart';
import 'package:icarus/features/finance/presentation/widgets/emoney_balance_header_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_history_card.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_history_list_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_status_badge.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class EmoneyScreen extends ConsumerWidget {
  const EmoneyScreen({super.key});

  static final _mockTransactions = [
    {
      'date': '15 Mar 2026',
      'description': 'Top Up E-Money',
      'amount': 'Rp 100.000',
      'type': TransactionType.kredit,
      'status': TransactionStatusType.berhasil,
    },
    {
      'date': '12 Mar 2026',
      'description': 'Pembelian Kantin',
      'amount': 'Rp 15.000',
      'type': TransactionType.debit,
      'status': TransactionStatusType.berhasil,
    },
    {
      'date': '10 Mar 2026',
      'description': 'Top Up E-Money',
      'amount': 'Rp 50.000',
      'type': TransactionType.kredit,
      'status': TransactionStatusType.menungguKonfirmasi,
    },
    {
      'date': '8 Mar 2026',
      'description': 'Pembelian Kantin',
      'amount': 'Rp 20.000',
      'type': TransactionType.debit,
      'status': TransactionStatusType.gagal,
    },
    {
      'date': '5 Mar 2026',
      'description': 'Top Up E-Money',
      'amount': 'Rp 200.000',
      'type': TransactionType.kredit,
      'status': TransactionStatusType.menungguPembayaran,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'E-Money',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          EmoneyBalanceHeaderWidget(
            onTopUp: () => context.pushNamed(RouteName.nominalEntry),
          ),
          Expanded(
            child: TransactionHistoryListWidget(
              transactions: _mockTransactions,
              onViewAll: () => context.pushNamed(RouteName.viewAllHistory),
              itemBuilder: (context, tx) {
                return TransactionHistoryCard(
                  date: tx['date'] as String,
                  description: tx['description'] as String,
                  amount: tx['amount'] as String,
                  type: tx['type'] as TransactionType,
                  trailing: TransactionStatusBadge(
                    status: tx['status'] as TransactionStatusType,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
