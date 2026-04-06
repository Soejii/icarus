import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/school/presentation/providers/school_controller.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/core/types/failure.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class UserInfoColumn extends ConsumerWidget {
  const UserInfoColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenAsync = ref.watch(childListControllerProvider);
    final selectedChild = ref.watch(selectedChildProvider);
    final schoolAsync = ref.watch(schoolControllerProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    final child = selectedChild ?? childrenAsync.valueOrNull?.firstOrNull;

    final childName = childrenAsync.isLoading
        ? '...'
        : child?.displayName ?? '...';

    final childSubtitle = child == null
        ? null
        : child.className != null
            ? 'Kelas ${child.className}'
            : child.nis;

    return Positioned(
      top: 85 + topPadding,
      left: 100.w,
      width: 180.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => context.pushNamed(RouteName.pilihAnakDidik),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: GradientText(
                      childName,
                      gradient: context.brand.mainGradient,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 14.sp,
                    color: const Color(0xFF539401),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            schoolAsync.when(
              data: (data) => data.name,
              error: (error, stackTrace) =>
                  error is NetworkFailure ? 'Offline' : 'Gagal Mengambil Data',
              loading: () => '...',
            ),
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (childSubtitle != null) ...[
            SizedBox(height: 2.h),
            Text(
              childSubtitle,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
