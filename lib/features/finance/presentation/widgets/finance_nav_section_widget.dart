import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/finance/presentation/widgets/finance_nav_card.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';

class FinanceNavSectionWidget extends StatelessWidget {
  const FinanceNavSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FinanceNavCard(
          icon: AssetsHelper.icSaving,
          title: 'Pembayaran Sekolah',
          routeName: RouteName.schoolBills,
        ),
        SizedBox(height: 12.h),
        FinanceNavCard(
          icon: AssetsHelper.icEmoney,
          title: 'E-Money',
          routeName: RouteName.emoney,
        ),
        SizedBox(height: 12.h),
        FinanceNavCard(
          icon: AssetsHelper.icSaving,
          title: 'Tabungan',
          routeName: RouteName.savings,
        ),
      ],
    );
  }
}
