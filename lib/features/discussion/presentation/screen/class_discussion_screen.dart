import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/discussion/presentation/providers/discussion_class_controller.dart';
import 'package:gaia/features/discussion/presentation/types/create_discussion_args.dart';
import 'package:gaia/features/discussion/presentation/types/create_discussion_type.dart';
import 'package:gaia/features/discussion/presentation/widgets/create_discussion_card.dart';
import 'package:gaia/features/discussion/presentation/widgets/discussion_post_card.dart';
import 'package:gaia/shared/presentation/divider_card.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClassDiscussionScreen extends HookConsumerWidget {
  const ClassDiscussionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDiscuss = ref.watch(discussionClassControllerProvider);
    final provider = ref.read(discussionClassControllerProvider.notifier);

    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.loadMore();
        }
      }

      scrollController.addListener(
        () => onScroll(),
      );
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Diskusi Kelas',
        leadingIcon: true,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(discussionClassControllerProvider.notifier).refresh(),
        child: ListView(
          children: [
            SizedBox(height: 16.h),
            const CreateDiscussionCard(
              type: CreateDiscussionArgs(
                type: CreateDiscussionType.kelas,
              ),
            ),
            SizedBox(height: 16.h),
            const DividerCard(),
            asyncDiscuss.when(
              data: (data) {
                if (data.items.isNotEmpty) {
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.items.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: DiscussionPostCard(
                        entity: data.items[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => const DividerCard(),
                  );
                } else {
                  return const DataNotFoundScreen(dataType: 'Diskusi Kelas');
                }
              },
              error: (error, stackTrace) => BufferErrorView(
                error: error,
                stackTrace: stackTrace,
                onRetry: () =>
                    ref.invalidate(discussionClassControllerProvider),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
