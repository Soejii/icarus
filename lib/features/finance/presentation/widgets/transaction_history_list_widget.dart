import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/transaction_type.dart';
import 'package:icarus/features/finance/presentation/widgets/transaction_history_card.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class TransactionHistoryListWidget extends StatelessWidget {
  const TransactionHistoryListWidget({
    super.key,
    this.transactions,
    this.onViewAll,
    this.itemBuilder,
  });

  final List<Map<String, dynamic>>? transactions;
  final VoidCallback? onViewAll;
  final Widget Function(BuildContext, Map<String, dynamic>)? itemBuilder;

  static final List<Map<String, dynamic>> defaultMockTransactions = [
    {
      'date': '15 Mar 2026',
      'description': 'Setoran Tabungan',
      'amount': 'Rp 200.000',
      'type': TransactionType.kredit,
    },
    {
      'date': '10 Mar 2026',
      'description': 'Penarikan Tabungan',
      'amount': 'Rp 50.000',
      'type': TransactionType.debit,
    },
    {
      'date': '5 Mar 2026',
      'description': 'Setoran Tabungan',
      'amount': 'Rp 300.000',
      'type': TransactionType.kredit,
    },
    {
      'date': '28 Feb 2026',
      'description': 'Penarikan Tabungan',
      'amount': 'Rp 100.000',
      'type': TransactionType.debit,
    },
    {
      'date': '20 Feb 2026',
      'description': 'Setoran Tabungan',
      'amount': 'Rp 150.000',
      'type': TransactionType.kredit,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final data = transactions ?? defaultMockTransactions;

    return Column(
      children: [
        if (onViewAll != null)
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
                  onTap: onViewAll,
                  child: GradientText(
                    'Lihat Semua',
                    gradient: context.brand.mainGradient,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.separated(
            itemCount: data.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: Color(0x1A000000)),
            itemBuilder: (context, index) {
              final tx = data[index];
              if (itemBuilder != null) {
                return itemBuilder!(context, tx);
              }
              return TransactionHistoryCard(
                date: tx['date'] as String,
                description: tx['description'] as String,
                amount: tx['amount'] as String,
                type: tx['type'] as TransactionType,
              );
            },
          ),
        ),
      ],
    );
  }
}
