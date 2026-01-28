import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/providers/emoney_history_controller.dart';
import 'package:gaia/features/balances/presentation/providers/savings_history_controller.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_history_item_widget.dart';
import 'package:gaia/features/balances/presentation/mappers/balance_type_ui_mapper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BalanceHistoryWidget extends ConsumerWidget {
  final BalanceType type;
  final int? itemLimit;

  const BalanceHistoryWidget({
    super.key,
    required this.type,
    this.itemLimit = 5,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Riwayat Transaksi',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(
                  RouteName.balanceHistory,
                  queryParameters: {
                    'type': BalanceTypeUIMapper.getRouteParameter(type)
                  },
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Lihat Semua',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF009ADE),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        if (type == BalanceType.emoney) ...[
          Consumer(
            builder: (context, ref, child) {
              final historyState = ref.watch(emoneyHistoryControllerProvider);

              return historyState.when(
                data: (pagedData) {
                  final historyList = pagedData.items;
                  if (historyList.isEmpty) {
                    return const DataNotFoundScreen(
                        dataType: 'Riwayat Transaksi');
                  }

                  final limitValue = itemLimit ?? historyList.length;
                  final displayList = limitValue < historyList.length
                      ? historyList.take(limitValue).toList()
                      : historyList;

                  return Column(
                    children: displayList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;

                      return Column(
                        children: [
                          BalanceHistoryItemWidget.emoney(emoneyItem: item),
                          if (index < displayList.length - 1)
                            Container(
                              height: 1.h,
                              color: Colors.black.withValues(alpha: 0.1),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                            ),
                        ],
                      );
                    }).toList(),
                  );
                },
                loading: () => SizedBox(
                  height: 200.h,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => BufferErrorView(
                  error: error,
                  stackTrace: stack,
                  onRetry: () =>
                      ref.invalidate(emoneyHistoryControllerProvider),
                ),
              );
            },
          ),
        ] else if (type == BalanceType.savings) ...[
          Consumer(
            builder: (context, ref, child) {
              final historyState = ref.watch(savingsHistoryControllerProvider);

              return historyState.when(
                data: (pagedData) {
                  final historyList = pagedData.items;
                  if (historyList.isEmpty) {
                    return const DataNotFoundScreen(
                        dataType: 'Riwayat Tabungan');
                  }

                  final limitValue = itemLimit ?? historyList.length;
                  final displayList = limitValue < historyList.length
                      ? historyList.take(limitValue).toList()
                      : historyList;

                  return Column(
                    children: displayList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;

                      return Column(
                        children: [
                          BalanceHistoryItemWidget.savings(savingsItem: item),
                          if (index < displayList.length - 1)
                            Container(
                              height: 1.h,
                              color: Colors.black.withValues(alpha: 0.1),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                            ),
                        ],
                      );
                    }).toList(),
                  );
                },
                loading: () => SizedBox(
                  height: 200.h,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => BufferErrorView(
                  error: error,
                  stackTrace: stack,
                  onRetry: () =>
                      ref.invalidate(savingsHistoryControllerProvider),
                ),
              );
            },
          ),
        ] else ...[
          const DataNotFoundScreen(dataType: 'Riwayat Transaksi'),
        ],
      ],
    );
  }
}
