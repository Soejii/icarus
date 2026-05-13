import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/domain/types/transaction_type.dart';
import 'package:icarus/features/finance/presentation/providers/saving_detail_controller.dart';
import 'package:icarus/features/finance/presentation/providers/saving_history_controller.dart';
import 'package:icarus/features/finance/presentation/widgets/savings_balance_header_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_history_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:intl/intl.dart';

class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({super.key});

  static const _previewCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(savingDetailControllerProvider);
    final historyAsync = ref.watch(savingHistoryControllerProvider);

    final balance = detailAsync.when(
      data: (d) => d != null ? formatRupiah(d.saldoTopup) : 'Rp. 0',
      loading: () => '...',
      error: (_, __) => 'Rp. 0',
    );

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Tabungan',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          SavingsBalanceHeaderWidget(balance: balance),
          Expanded(
            child: historyAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text(e.toString())),
              data: (transactions) => _historyPreview(
                context,
                transactions,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyPreview(
    BuildContext context,
    List<SavingTransactionEntity> transactions,
  ) {
    final preview = transactions.take(_previewCount).toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Riwayat Transaksi',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
              GestureDetector(
                onTap: () => context.pushNamed(
                  RouteName.viewAllHistory,
                  extra: 'saving',
                ),
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (preview.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 32.h),
            child: Text(
              'Belum ada transaksi',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 13.sp,
                color: context.brand.textSecondary,
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              itemCount: preview.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0x1A000000)),
              itemBuilder: (context, i) =>
                  _savingCard(preview[i]),
            ),
          ),
      ],
    );
  }

  Widget _savingCard(SavingTransactionEntity tx) {
    final isDebit = tx.transaction == 'cashout';
    return TransactionHistoryCard(
      date: _formatDate(tx.date),
      description: tx.notes?.isNotEmpty == true ? tx.notes! : tx.transaction,
      amount: formatRupiah(tx.amount),
      type: isDebit ? TransactionType.debit : TransactionType.kredit,
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('d MMM yyyy', 'id_ID').format(dt);
  }
}
