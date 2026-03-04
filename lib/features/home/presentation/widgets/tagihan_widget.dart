import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/home/presentation/widgets/tagihan_card.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class TagihanWidget extends StatelessWidget {
  const TagihanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tagihan',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: GradientText(
                  'Lihat Semua',
                  gradient: context.brand.mainGradient,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const TagihanCard(
            amount: 'Rp 500.000',
            description: 'SPP November 2021',
            date: '15 November 2021',
            isPaid: true,
          ),
          const Divider(height: 1, color: Color(0x1A000000)),
          const TagihanCard(
            amount: 'Rp 700.000',
            description: 'Uang Seragam',
            date: '15 November 2021',
            isPaid: false,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
