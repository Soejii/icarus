import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class PaymentDeadlineWidget extends StatelessWidget {
  const PaymentDeadlineWidget({
    super.key,
    required this.deadline,
    required this.transactionId,
  });

  final String deadline;
  final String transactionId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.red, size: 14),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  'Pastikan nominal transfer sesuai hingga 3 digit terakhir.',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 17.h),
          Text(
            'Batas Pembayaran',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 7.h),
          Text(
            deadline,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'ID Transaksi',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 7.h),
          Text(
            '#$transactionId',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
        ],
      ),
    );
  }
}
