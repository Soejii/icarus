import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_status_badge.dart';

class InstallmentHistoryListWidget extends StatelessWidget {
  const InstallmentHistoryListWidget({
    super.key,
    required this.installments,
  });

  final List<Map<String, dynamic>> installments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Tagihan',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 15.h),
          ListView.builder(
            itemCount: installments.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = installments[index];
              final status = item['status'] as BillStatusType;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['nominal'] as String,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: status.nominalColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            item['date'] as String,
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
                    BillStatusBadge(status: status),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
