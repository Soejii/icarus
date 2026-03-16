import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class FinanceUnpaidSummaryWidget extends StatelessWidget {
  const FinanceUnpaidSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Rp 2.500.000',
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
          _buildBreakdownRow(context, 'SPP', 'Rp 1.000.000'),
          SizedBox(height: 6.h),
          _buildBreakdownRow(context, 'DPP', 'Rp 1.200.000'),
          SizedBox(height: 6.h),
          _buildBreakdownRow(context, 'Lainnya', 'Rp 300.000'),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(BuildContext context, String label, String amount) {
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
