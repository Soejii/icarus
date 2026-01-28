import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/providers/emoney_controller.dart';
import 'package:gaia/features/balances/presentation/providers/savings_controller.dart';
import 'package:gaia/features/balances/presentation/mappers/balance_summary_ui_mapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BalanceSummaryWidget extends ConsumerWidget {
  final BalanceType type;

  const BalanceSummaryWidget({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryItems = BalanceSummaryUIMapper.getItems(type);

    if (type == BalanceType.emoney) {
      final emoney = ref.watch(emoneyControllerProvider).value;
      final values = [
        emoney?.totalTopup ?? 'Rp 0',
        emoney?.totalCashout ?? 'Rp 0',
        emoney?.totalPayment ?? 'Rp 0',
      ];

      return _buildSummaryColumn(
        summaryItems,
        values,
        context,
      );
    } else {
      final savings = ref.watch(savingsControllerProvider).value;
      final values = [
        savings?.totalDebit ?? 'Rp 0',
        savings?.totalKredit ?? 'Rp 0',
      ];

      return _buildSummaryColumn(
        summaryItems,
        values,
        context,
      );
    }
  }

  Widget _buildSummaryColumn(
    List<BalanceSummaryItem> items,
    List<String> values,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final value = index < values.length ? values[index] : 'Rp 0';

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.brand.textMain,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: item.color,
                    ),
                  ),
                ],
              ),
              if (index < items.length - 1) SizedBox(height: 8.h),
            ],
          );
        }),
        SizedBox(height: 20.h),
        Container(
          height: 3.h,
          width: double.infinity,
          color: Colors.black.withValues(alpha: 0.1),
        ),
      ],
    );
  }
}
