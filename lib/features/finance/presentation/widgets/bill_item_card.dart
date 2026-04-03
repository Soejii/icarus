import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_status_badge.dart';

class BillItemCard extends StatelessWidget {
  const BillItemCard({
    super.key,
    required this.nominal,
    required this.jenisPembayaran,
    required this.date,
    required this.status,
    this.onPressed,
  });

  final String nominal;
  final String jenisPembayaran;
  final String date;
  final BillStatusType status;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nominal,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: status.nominalColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      jenisPembayaran,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textSecondary,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      date,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textMain,
                      ),
                    ),
                  ],
                ),
              ),
              BillStatusBadge(
                status: status,
                onTap: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
