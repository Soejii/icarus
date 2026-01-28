import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/providers/emoney_controller.dart';
import 'package:gaia/features/balances/presentation/providers/savings_controller.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_card_widget.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_summary_widget.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_history_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BalanceContentScreen extends ConsumerWidget {
  final BalanceType type;

  const BalanceContentScreen({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceState = type == BalanceType.emoney 
        ? ref.watch(emoneyControllerProvider)
        : ref.watch(savingsControllerProvider);

    return balanceState.when(
      data: (data) => SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            BalanceCardWidget(type: type),
            SizedBox(height: 40.h),
            BalanceSummaryWidget(type: type),
            SizedBox(height: 24.h),
            BalanceHistoryWidget(
              type: type,
              itemLimit: 5,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.r, color: Colors.red),
            SizedBox(height: 16.h),
            Text('Terjadi kesalahan saat memuat data', style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 8.h),
            Text(error.toString(), style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                if (type == BalanceType.emoney) {
                  ref.read(emoneyControllerProvider.notifier).refresh();
                } else {
                  ref.read(savingsControllerProvider.notifier).refresh();
                }
              },
              child: const Text('Gagal, Silahkan Coba Lagi"'),
            ),
          ],
        ),
      ),
    );
  }
}
