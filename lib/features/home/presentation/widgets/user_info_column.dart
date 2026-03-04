import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/profile/presentation/providers/profile_controller.dart';
import 'package:icarus/features/school/presentation/providers/school_controller.dart';
import 'package:icarus/shared/core/types/failure.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfoColumn extends ConsumerWidget {
  const UserInfoColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(profileControllerProvider);
    final schoolAsync = ref.watch(schoolControllerProvider);

    // Extract user name safely
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 85 + topPadding,
      left: 100.w,
      width: 180.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                    userAsync.when(
                      data: (u) => u.name,
                      loading: () => '...',
                      error: (error, stackTrace) =>
                          error is NetworkFailure ? 'Offline' : 'Error',
                    ),
                    gradient: context.brand.mainGradient,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
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
          SizedBox(height: 2.h),
          Text(
            schoolAsync.when(
              data: (data) => data.name,
              error: (error, stackTrace) =>
                  error is NetworkFailure ? 'Offline' : 'Gagal Mengambil Data',
              loading: () => '...',
            ),
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            userAsync.when(
              data: (u) => 'Kelas ${u.className}',
              loading: () => '...',
              error: (_, __) => '',
            ),
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
