import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:intl/intl.dart';

class BillDetailSectionWidget extends ConsumerWidget {
  const BillDetailSectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(paymentFlowNotifierProvider).selectedBill;

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
            'Detail Tagihan',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 12.h),
          detailRow(context, 'Nama Tagihan', bill?.billName ?? '-'),
          SizedBox(height: 8.h),
          detailRow(context, 'Kategori', bill?.category.label ?? '-'),
          SizedBox(height: 8.h),
          detailRow(context, 'Jumlah', formatRupiah(bill?.billAmount)),
          SizedBox(height: 8.h),
          detailRow(
            context,
            'Jatuh Tempo',
            bill?.endDate != null
                ? DateFormat('d MMM yyyy', 'id_ID').format(bill!.endDate!)
                : '-',
          ),
        ],
      ),
    );
  }

  detailRow(BuildContext context, String label, String value) {
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
          value,
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
