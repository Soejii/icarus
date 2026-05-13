import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/entities/emoney_transaction_entity.dart';
import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/domain/types/transaction_type.dart';
import 'package:icarus/features/finance/presentation/providers/emoney_history_controller.dart';
import 'package:icarus/features/finance/presentation/providers/saving_history_controller.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_history_card.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:intl/intl.dart';

class ViewAllHistoryScreen extends ConsumerStatefulWidget {
  const ViewAllHistoryScreen({super.key, required this.historyType});

  /// 'emoney' or 'saving'
  final String historyType;

  @override
  ConsumerState<ViewAllHistoryScreen> createState() =>
      _ViewAllHistoryScreenState();
}

class _ViewAllHistoryScreenState
    extends ConsumerState<ViewAllHistoryScreen> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    try {
      if (widget.historyType == 'emoney') {
        await ref.read(emoneyHistoryControllerProvider.notifier).loadMore();
      } else {
        await ref.read(savingHistoryControllerProvider.notifier).loadMore();
      }
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: widget.historyType == 'emoney'
            ? 'Riwayat E-Money'
            : 'Riwayat Tabungan',
        leadingIcon: true,
      ),
      body: widget.historyType == 'emoney'
          ? _emoneyList()
          : _savingList(),
    );
  }

  Widget _emoneyList() {
    final state = ref.watch(emoneyHistoryControllerProvider);
    final hasMore =
        ref.watch(emoneyHistoryControllerProvider.notifier).hasMore;

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (transactions) => _list(
        itemCount: transactions.length,
        hasMore: hasMore,
        itemBuilder: (i) {
          final tx = transactions[i];
          return TransactionHistoryCard(
            date: _formatDate(tx.date),
            description: tx.notes?.isNotEmpty == true
                ? tx.notes!
                : tx.merchantName ?? tx.transaction,
            amount: formatRupiah(tx.amount),
            type:
                tx.isDebit ? TransactionType.debit : TransactionType.kredit,
          );
        },
      ),
    );
  }

  Widget _savingList() {
    final state = ref.watch(savingHistoryControllerProvider);
    final hasMore =
        ref.watch(savingHistoryControllerProvider.notifier).hasMore;

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (transactions) => _list(
        itemCount: transactions.length,
        hasMore: hasMore,
        itemBuilder: (i) {
          final tx = transactions[i];
          final isDebit = tx.transaction == 'cashout';
          return TransactionHistoryCard(
            date: _formatDate(tx.date),
            description:
                tx.notes?.isNotEmpty == true ? tx.notes! : tx.transaction,
            amount: formatRupiah(tx.amount),
            type: isDebit ? TransactionType.debit : TransactionType.kredit,
          );
        },
      ),
    );
  }

  Widget _list({
    required int itemCount,
    required bool hasMore,
    required Widget Function(int) itemBuilder,
  }) {
    if (itemCount == 0) {
      return Center(
        child: Text(
          'Belum ada transaksi',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 13.sp,
            color: context.brand.textSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      itemCount: itemCount + (hasMore ? 1 : 0),
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0x1A000000)),
      itemBuilder: (context, i) {
        if (i == itemCount) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        return itemBuilder(i);
      },
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('d MMM yyyy', 'id_ID').format(dt);
  }
}
