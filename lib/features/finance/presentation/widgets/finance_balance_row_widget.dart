import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/providers/emoney_detail_controller.dart';
import 'package:icarus/features/finance/presentation/providers/saving_detail_controller.dart';
import 'package:icarus/features/finance/presentation/widgets/finance_balance_card.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:icarus/shared/utils/currency_helper.dart';

class FinanceBalanceRowWidget extends ConsumerWidget {
  const FinanceBalanceRowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emoney = ref.watch(emoneyDetailControllerProvider);
    final saving = ref.watch(savingDetailControllerProvider);

    String amountText(AsyncValue<dynamic> value, int? amount) {
      if (value.isLoading) return '...';
      if (value.hasError) return '-';
      return formatRupiah(amount);
    }

    return Row(
      children: [
        FinanceBalanceCard(
          icon: AssetsHelper.icSaving,
          label: 'Saldo Tabungan',
          amount: amountText(saving, saving.valueOrNull?.saldoTopup),
          color: context.brand.primary,
        ),
        SizedBox(width: 12.w),
        FinanceBalanceCard(
          icon: AssetsHelper.icEmoney,
          label: 'Saldo E-Money',
          amount: amountText(emoney, emoney.valueOrNull?.saldoEmoney),
          color: context.brand.primary,
        ),
      ],
    );
  }
}
