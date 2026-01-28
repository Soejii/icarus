import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/discussion/presentation/types/create_discussion_args.dart';
import 'package:gaia/features/profile/presentation/providers/profile_controller.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:gaia/shared/core/types/failure.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateDiscussionCard extends ConsumerWidget {
  const CreateDiscussionCard({super.key, required this.type});
  final CreateDiscussionArgs type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 48.h,
            width: 48.h,
            child: profileAsync.when(
              data: (data) => CircleAvatar(
                foregroundImage: NetworkImage(
                  data.imgUrl,
                ),
                backgroundImage: AssetImage(
                  AssetsHelper.imgProfilePlaceholder,
                ),
              ),
              error: (error, stackTrace) => Text(
                  error is NetworkFailure ? 'Offline' : 'Terjadi Kesalahan'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.pushNamed(RouteName.createDiscussion, extra: type);
              },
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: context.brand.textSecondary, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  child: Text(
                    'Apa yang ingin kamu diskusikan?',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
