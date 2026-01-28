import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/providers/emoney_history_controller.dart';
import 'package:gaia/features/balances/presentation/providers/savings_history_controller.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_history_item_widget.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BalanceHistoryListWidget extends HookConsumerWidget {
  final BalanceType type;

  const BalanceHistoryListWidget({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useEffect(
      () {
        void onScroll() {
          if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200) {
            if (type == BalanceType.emoney) {
              ref.read(emoneyHistoryControllerProvider.notifier).loadMore();
            } else if (type == BalanceType.savings) {
              ref.read(savingsHistoryControllerProvider.notifier).loadMore();
            }
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    return switch (type) {
      BalanceType.emoney => Consumer(
          builder: (context, ref, child) {
            final historyState = ref.watch(emoneyHistoryControllerProvider);
            return historyState.when(
              data: (pagedData) {
                final historyList = pagedData.items;
                if (historyList.isEmpty) {
                  return const DataNotFoundScreen(
                      dataType: 'Riwayat Transaksi');
                }

                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(emoneyHistoryControllerProvider.notifier)
                      .refresh(),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: historyList.length + (pagedData.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == historyList.length) {
                        return pagedData.isMoreLoading
                            ? Container(
                                padding: EdgeInsets.all(16.h),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                              )
                            : const SizedBox.shrink();
                      }

                      final item = historyList[index];
                      return Column(
                        children: [
                          BalanceHistoryItemWidget.emoney(emoneyItem: item),
                          if (index < historyList.length - 1)
                            Container(
                              height: 1.h,
                              color: Colors.black.withValues(alpha: 0.1),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                            ),
                        ],
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => BufferErrorView(
                error: error,
                stackTrace: stack,
                onRetry: () => ref.invalidate(emoneyHistoryControllerProvider),
              ),
            );
          },
        ),
      BalanceType.savings => Consumer(
          builder: (context, ref, child) {
            final historyState = ref.watch(savingsHistoryControllerProvider);
            return historyState.when(
              data: (pagedData) {
                final historyList = pagedData.items;
                if (historyList.isEmpty) {
                  return const DataNotFoundScreen(dataType: 'Riwayat Tabungan');
                }

                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(savingsHistoryControllerProvider.notifier)
                      .refresh(),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: historyList.length + (pagedData.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == historyList.length) {
                        return pagedData.isMoreLoading
                            ? Container(
                                padding: EdgeInsets.all(16.h),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                              )
                            : const SizedBox.shrink();
                      }

                      final item = historyList[index];
                      return Column(
                        children: [
                          BalanceHistoryItemWidget.savings(savingsItem: item),
                          if (index < historyList.length - 1)
                            Container(
                              height: 1.h,
                              color: Colors.black.withValues(alpha: 0.1),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                            ),
                        ],
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => BufferErrorView(
                error: error,
                stackTrace: stack,
                onRetry: () => ref.invalidate(savingsHistoryControllerProvider),
              ),
            );
          },
        ),
    };
  }
}
