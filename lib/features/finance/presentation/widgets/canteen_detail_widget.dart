import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class CanteenDetailWidget extends StatelessWidget {
  const CanteenDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Nasi Goreng', 'qty': '1x', 'price': 'Rp 15.000'},
      {'name': 'Es Teh Manis', 'qty': '2x', 'price': 'Rp 10.000'},
      {'name': 'Roti Bakar', 'qty': '1x', 'price': 'Rp 8.000'},
    ];

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
            'Detail Pesanan Kantin',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 12.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      item['name']!,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textMain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      item['qty']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      item['price']!,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: context.brand.textMain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
