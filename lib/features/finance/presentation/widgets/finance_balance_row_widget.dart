import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/finance_balance_card.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';

class FinanceBalanceRowWidget extends StatelessWidget {
  const FinanceBalanceRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FinanceBalanceCard(
          icon: AssetsHelper.icSaving,
          label: 'Saldo Tabungan',
          amount: 'Rp 1.500.000',
          color: context.brand.primary,
        ),
        SizedBox(width: 12.w),
        FinanceBalanceCard(
          icon: AssetsHelper.icEmoney,
          label: 'Saldo E-Money',
          amount: 'Rp 250.000',
          color: context.brand.primary,
        ),
      ],
    );
  }
}
