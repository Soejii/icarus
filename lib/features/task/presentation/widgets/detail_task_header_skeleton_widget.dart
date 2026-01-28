import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/task/presentation/widgets/detail_task_header_info_card.dart';

class DetailTaskHeaderSkeletonWidget extends StatelessWidget {
  const DetailTaskHeaderSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailTaskHeaderInfoCard(
              icon: Icons.calendar_month_rounded,
              title: 'Batas Pengumpulan',
              value: '............',
            ),
            SizedBox(height: 8.h),
            const DetailTaskHeaderInfoCard(
              icon: Icons.assignment_outlined,
              title: 'Judul Tugas',
              value: '............',
            ),
            SizedBox(height: 8.h),
            const DetailTaskHeaderInfoCard(
              icon: Icons.person,
              title: 'Guru Pengajar',
              value: '............',
            ),
          ],
        ),
      ),
    );
  }
}
