import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/performance/domain/types/performance_type.dart';
import 'package:icarus/features/performance/presentation/widgets/performance_card.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class NilaiMuridWidget extends StatelessWidget {
  const NilaiMuridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Nilai Murid',
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
        ),
        PerformanceCard(type: PerformanceType.exam),
        PerformanceCard(type: PerformanceType.quiz),
        SizedBox(height: 16.h),
      ],
    );
  }
}
