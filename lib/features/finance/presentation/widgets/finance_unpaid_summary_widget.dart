import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/providers/home_bill_controller.dart';
import 'package:icarus/shared/utils/currency_helper.dart';

class FinanceUnpaidSummaryWidget extends ConsumerWidget {
  const FinanceUnpaidSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBill = ref.watch(homeBillControllerProvider);

    String amountText(int? amount) {
      if (homeBill.isLoading) return '...';
      if (homeBill.hasError) return '-';
      return formatRupiah(amount);
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Tagihan Belum Dibayar',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            amountText(homeBill.valueOrNull?.unpaidTotal),
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFF7171),
            ),
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1, color: Color(0x1A000000)),
          SizedBox(height: 12.h),
          breakdownRow(context, 'SPP', amountText(homeBill.valueOrNull?.unpaidSpp)),
          SizedBox(height: 6.h),
          breakdownRow(context, 'DPP', amountText(homeBill.valueOrNull?.unpaidDpp)),
          SizedBox(height: 6.h),
          breakdownRow(context, 'Lainnya', amountText(homeBill.valueOrNull?.unpaidLainnya)),
        ],
      ),
    );
  }

  breakdownRow(BuildContext context, String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textSecondary,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: context.brand.textMain,
          ),
        ),
      ],
    );
  }
}
