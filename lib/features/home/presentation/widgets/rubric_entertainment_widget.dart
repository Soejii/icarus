import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/announcement/presentation/widgets/announcement_error_card.dart';
import 'package:gaia/features/announcement/presentation/widgets/announcement_skeleton_card.dart';
import 'package:gaia/features/edutainment/domain/type/edutainment_type.dart';
import 'package:gaia/features/edutainment/presentation/providers/edutainment_controller.dart';
import 'package:gaia/features/edutainment/presentation/widgets/edutainment_card.dart';
import 'package:go_router/go_router.dart';

class RubricEntertainmentWidget extends ConsumerWidget {
  const RubricEntertainmentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edutainmentAsync =
        ref.watch(edutainmentControllerProvider(EdutainmentType.all));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rubrik Entertainment',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed('list-edutainment');
                },
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          edutainmentAsync.when(
            data: (data) => data.items.isNotEmpty
                ? EdutainmentCard(entity: data.items[0])
                : const SizedBox.shrink(),
            error: (e, _) => AnnouncementErrorCard(
              error: e,
              onRetry: () => ref.invalidate(edutainmentControllerProvider),
            ),
            loading: () => const AnnouncementSkeletonCard(),
          ),
        ],
      ),
    );
  }
}
