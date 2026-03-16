import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/finance/presentation/widgets/finance_balance_row_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/finance_nav_section_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/finance_pocket_limit_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/finance_unpaid_summary_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Keuangan',
        leadingIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FinanceBalanceRowWidget(),
            SizedBox(height: 16.h),
            const FinanceUnpaidSummaryWidget(),
            SizedBox(height: 16.h),
            const FinanceNavSectionWidget(),
            SizedBox(height: 16.h),
            const FinancePocketLimitWidget(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
