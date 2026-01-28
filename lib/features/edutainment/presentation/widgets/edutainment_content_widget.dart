import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/edutainment/domain/type/edutainment_type.dart';
import 'package:gaia/features/edutainment/presentation/providers/edutainment_controller.dart';
import 'package:gaia/features/edutainment/presentation/widgets/edutainment_card.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EdutainmentContentWidget extends HookConsumerWidget {
  const EdutainmentContentWidget({super.key, required this.type});
  final EdutainmentType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEdu = ref.watch(edutainmentControllerProvider(type));
    final provider = ref.read(edutainmentControllerProvider(type).notifier);

    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.loadMore();
          log('sss');
        }
      }

      scrollController.addListener(
        () => onScroll(),
      );
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return asyncEdu.when(
      data: (data) {
        if (data.items.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () => ref
                .read(edutainmentControllerProvider(type).notifier)
                .refresh(),
            child: ListView.separated(
              controller: scrollController,
              itemCount: data.items.length + (data.isMoreLoading ? 1 : 0),
              itemBuilder: (context, i) {
                if (i >= data.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final item = data.items[i];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: EdutainmentCard(entity: item),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
            ),
          );
        } else {
          return const DataNotFoundScreen(dataType: 'Edutainment');
        }
      },
      error: (error, stackTrace) => BufferErrorView(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(edutainmentControllerProvider(type)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
