import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/features/subject/presentation/widgets/detail_subject_title_card.dart';
import 'package:go_router/go_router.dart';

class DetailSubjectAppBarWidget extends StatelessWidget {
  const DetailSubjectAppBarWidget({super.key, required this.entity});
  final SubjectEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.brand.primary,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.h),
            GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            DetailSubjectTitleCard(entity: entity)
          ],
        ),
      ),
    );
  }
}
