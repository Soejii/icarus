import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/discussion/presentation/providers/create_discussion_controller.dart';
import 'package:gaia/features/discussion/presentation/types/create_discussion_args.dart';
import 'package:gaia/features/profile/presentation/providers/profile_controller.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/types/failure.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateDiscussionScreen extends HookConsumerWidget {
  const CreateDiscussionScreen({super.key, required this.type});
  final CreateDiscussionArgs type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final profileAsync = ref.watch(profileControllerProvider);
    final controller = ref.watch(createDiscussionControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Buat Diskusi',
        leadingIcon: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 42.h,
                  width: 42.h,
                  child: profileAsync.when(
                    data: (data) => CircleAvatar(
                      foregroundImage: NetworkImage(
                        data.imgUrl,
                      ),
                      backgroundImage: AssetImage(
                        AssetsHelper.imgProfilePlaceholder,
                      ),
                    ),
                    error: (error, stackTrace) => Text(error is NetworkFailure
                        ? 'Offline'
                        : 'Terjadi Kesalahan'),
                    loading: () => const CircularProgressIndicator(),
                  ),
                ),
                SizedBox(width: 7.w),
                profileAsync.when(
                  data: (data) => Text(
                    data.name,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: context.brand.textMain,
                    ),
                  ),
                  error: (error, stackTrace) => Text(error is NetworkFailure
                      ? 'Offline'
                      : 'Terjadi Kesalahan'),
                  loading: () => const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
          SizedBox(height: 26.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              constraints: BoxConstraints(minHeight: 56.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: context.brand.textSecondary, width: 1),
              ),
              child: TextField(
                controller: textController,
                minLines: 2,
                maxLines: 15,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textMain,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tulis Diskusi Kamu Disini!',
                  hintStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textMain,
                    fontStyle: FontStyle.italic,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80.h,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: GestureDetector(
            onTap: () async {
              final res = await ref
                  .read(createDiscussionControllerProvider.notifier)
                  .createDiscussion(type, textController.text);

              res.fold(
                (f) => throw f,
                (_) => context.pop(),
              );
            },
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: context.brand.primary,
                      boxShadow: context.brand.shadow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Posting',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
