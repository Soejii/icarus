import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/profile/presentation/providers/profile_controller.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:icarus/shared/core/types/failure.dart';

class UserAvatarWidget extends ConsumerWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 85 + topPadding,
      left: 25.w,
      child: Container(
        height: 56,
        width: 56,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: profileAsync.when(
          data: (data) => CircleAvatar(
            foregroundImage: NetworkImage(
              data.imgUrl,
            ),
            backgroundImage: AssetImage(
              AssetsHelper.imgProfilePlaceholder,
            ),
          ),
          error: (error, stackTrace) =>
              Text(error is NetworkFailure ? 'Offline' : 'Terjadi Kesalahan'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
