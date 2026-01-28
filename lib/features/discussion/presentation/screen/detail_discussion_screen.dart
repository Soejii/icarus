import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/discussion/presentation/providers/create_comment_controller.dart';
import 'package:gaia/features/discussion/presentation/providers/detail_discussion_controller.dart';
import 'package:gaia/features/discussion/presentation/widgets/comment_card.dart';
import 'package:gaia/features/discussion/presentation/widgets/discussion_card.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailDiscussionScreen extends HookConsumerWidget {
  const DetailDiscussionScreen({super.key, required this.idDiscussion});
  final int idDiscussion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final asyncDetail =
        ref.watch(detailDiscussionControllerProvider(idDiscussion));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Detail Postingan',
        leadingIcon: true,
      ),
      body: asyncDetail.when(
        data: (data) => ListView(
          children: [
            SizedBox(height: 24.h),
            DiscussionCard(
              isDetail: true,
              entity: data.poster,
            ),
            SizedBox(height: 10.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.comments?.length ?? 0,
              itemBuilder: (context, index) => CommentCard(
                entity: data.comments?[index],
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
            ),
          ],
        ),
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () =>
              ref.invalidate(detailDiscussionControllerProvider(idDiscussion)),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 80.h,
          decoration:  BoxDecoration(
            color: Colors.white,
            boxShadow: context.brand.invertedShadow,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromRGBO(0, 0, 0, 0.10),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: textController,
                      minLines: 1,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textMain,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tulis Komentar!',
                        hintStyle: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: context.brand.inactive,
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 10.h),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () async {
                    final res = await ref
                        .read(createCommentControllerProvider.notifier)
                        .createComment(textController.text, idDiscussion);

                    res.fold(
                      (f) => throw f,
                      (_) => textController.clear(),
                    );
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.brand.primary,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
