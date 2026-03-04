import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class TagihanCard extends StatelessWidget {
  const TagihanCard({
    super.key,
    required this.amount,
    required this.description,
    required this.date,
    required this.isPaid,
  });

  final String amount;
  final String description;
  final String date;
  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isPaid
                    ? GradientText(
                        amount,
                        gradient: context.brand.mainGradient,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        amount,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF7171),
                        ),
                      ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF526789),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF052049),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isPaid
                  ? const Color(0xFF5AAF55)
                  : const Color(0xFFFF7171),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isPaid ? 'Sudah Dibayar' : 'Belum Dibayar',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
