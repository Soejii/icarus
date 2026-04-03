import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_history_list_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ViewAllHistoryScreen extends ConsumerWidget {
  const ViewAllHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Riwayat Transaksi',
        leadingIcon: true,
      ),
      body: const TransactionHistoryListWidget(),
    );
  }
}
