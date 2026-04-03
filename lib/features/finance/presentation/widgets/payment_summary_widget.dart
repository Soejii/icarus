import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({
    super.key,
    this.items,
  });

  final List<Map<String, String>>? items;

  static final _defaultItems = [
    {'label': 'SPP Maret 2026', 'value': 'Rp 500.000'},
    {'label': 'Biaya Admin', 'value': 'Rp 2.500'},
    {'label': 'Total', 'value': 'Rp 502.500'},
  ];

  @override
  Widget build(BuildContext context) {
    final data = items ?? _defaultItems;

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
            'Rincian Pembayaran',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 12.h),
          ...data.asMap().entries.map((entry) {
            final item = entry.value;
            final isLast = entry.key == data.length - 1;
            return Column(
              children: [
                if (isLast) ...[
                  const Divider(height: 1, color: Color(0x1A000000)),
                  SizedBox(height: 8.h),
                ],
                Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['label']!,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          fontWeight:
                              isLast ? FontWeight.w700 : FontWeight.w400,
                          color: isLast
                              ? context.brand.textMain
                              : context.brand.textSecondary,
                        ),
                      ),
                      Text(
                        item['value']!,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          fontWeight:
                              isLast ? FontWeight.w700 : FontWeight.w600,
                          color: context.brand.textMain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
