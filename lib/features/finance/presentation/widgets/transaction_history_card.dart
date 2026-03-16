import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/transaction_type.dart';

class TransactionHistoryCard extends StatelessWidget {
  const TransactionHistoryCard({
    super.key,
    required this.date,
    required this.description,
    required this.amount,
    required this.type,
    this.trailing,
  });

  final String date;
  final String description;
  final String amount;
  final TransactionType type;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isKredit = type == TransactionType.kredit;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: isKredit
                  ? const Color(0xFF5AAF55).withOpacity(0.1)
                  : const Color(0xFFFF7171).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              isKredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isKredit
                  ? const Color(0xFF5AAF55)
                  : const Color(0xFFFF7171),
              size: 20.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isKredit ? '+' : '-'} $amount',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isKredit
                      ? const Color(0xFF5AAF55)
                      : const Color(0xFFFF7171),
                ),
              ),
              if (trailing != null) ...[
                SizedBox(height: 4.h),
                trailing!,
              ],
            ],
          ),
        ],
      ),
    );
  }
}
