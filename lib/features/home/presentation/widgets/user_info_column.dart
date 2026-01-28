import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/profile/presentation/providers/profile_controller.dart';
import 'package:gaia/features/school/presentation/providers/school_controller.dart';
import 'package:gaia/shared/core/types/failure.dart';
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
          Text(
            // User name
            userAsync.when(
              data: (u) => u.name,
              loading: () => '...',
              error: (error, stackTrace) =>
                  error is NetworkFailure ? 'Offline' : '$stackTrace',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
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
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Murid',
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
