import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/features/subject/presentation/providers/module_controller.dart';

class DetailSubjectTitleCard extends ConsumerWidget {
  const DetailSubjectTitleCard({super.key, required this.entity});
  final SubjectEntity entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCount = ref.watch(moduleControllerProvider(entity.id));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 72.h,
          width: 72.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(201, 238, 255, 1),
                Color.fromRGBO(255, 255, 255, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: context.brand.shadow,
          ),
          child: Center(
            child: SizedBox(
              height: 56.h,
              width: 56.h,
              child: Image.asset(
                entity.iconCode,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                entity.name ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              asyncCount.when(
                data: (data) => Text(
                  '${ref.watch(moduleControllerProvider(entity.id).notifier).totalModuleCount} Modul | ${ref.watch(moduleControllerProvider(entity.id).notifier).totalSubModuleCount} Submodul | ${ref.watch(moduleControllerProvider(entity.id).notifier).totalExamCount} Latihan Soal',
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                error: (error, stackTrace) => Text('Terjadi Kesalahan, $error'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        )
      ],
    );
  }
}
