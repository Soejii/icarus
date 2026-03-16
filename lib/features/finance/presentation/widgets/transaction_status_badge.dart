import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/finance/domain/types/transaction_status_type.dart';

class TransactionStatusBadge extends StatelessWidget {
  const TransactionStatusBadge({super.key, required this.status});

  final TransactionStatusType status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
          color: status.color,
        ),
      ),
    );
  }
}
