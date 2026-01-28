import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/profile/presentation/providers/profile_controller.dart';
import 'package:gaia/features/profile/presentation/widgets/profile_menu_widget.dart';
import 'package:gaia/features/profile/presentation/widgets/user_avatar_profile_widget.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Profil',
        leadingIcon: false,
      ),
      body: profileAsync.when(
        error: (e, _) => BufferErrorView(
          error: e,
          stackTrace: _,
          onRetry: () => ref.invalidate(profileControllerProvider),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (data) => ListView(
          children: [
            SizedBox(height: 56.h),
            UserAvatarProfileWidget(
              imgUrl: data.imgUrl,
              name: data.name,
              className: data.className,
            ),
            SizedBox(height: 38.h),
            const ProfileMenuWidget(),
            SizedBox(height: 30.h),
            Center(
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
