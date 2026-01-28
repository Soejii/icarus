import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/school/presentation/providers/school_controller.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SchoolAvatarWidget extends ConsumerWidget {
  const SchoolAvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolAsync = ref.watch(schoolControllerProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      right: 25.w,
      top: 85 + topPadding,
      child: SizedBox(
          height: 56.h,
          width: 56.h,
          child: schoolAsync.when(
            data: (data) => CircleAvatar(
              foregroundImage: NetworkImage(
                data.photo,
              ),
              backgroundImage: AssetImage(
                AssetsHelper.imgProfilePlaceholder,
              ),
            ),
            error: (error, stackTrace) => CircleAvatar(
              backgroundImage: AssetImage(
                AssetsHelper.imgProfilePlaceholder,
              ),
            ),
            loading: () => const CircularProgressIndicator(),
          )),
    );
  }
}
