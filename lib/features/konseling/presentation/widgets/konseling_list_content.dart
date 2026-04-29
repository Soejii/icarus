import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/features/konseling/presentation/providers/konseling_controller.dart';
import 'package:icarus/features/konseling/presentation/widgets/konseling_card.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';

class KonselingListContent extends ConsumerStatefulWidget {
  const KonselingListContent({super.key, required this.type});

  final KonselingType type;

  @override
  ConsumerState<KonselingListContent> createState() =>
      _KonselingListContentState();
}

class _KonselingListContentState extends ConsumerState<KonselingListContent> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(konselingControllerProvider(widget.type).notifier)
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(konselingControllerProvider(widget.type));

    return asyncState.when(
      data: (data) {
        if (data.items.isEmpty) {
          return const DataNotFoundScreen(dataType: 'Konseling');
        }
        return RefreshIndicator(
          onRefresh: () => ref
              .read(konselingControllerProvider(widget.type).notifier)
              .refresh(),
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemCount: data.items.length + (data.isMoreLoading ? 1 : 0),
            itemBuilder: (_, i) {
              if (i >= data.items.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return KonselingCard(entity: data.items[i]);
            },
          ),
        );
      },
      error: (error, stack) => BufferErrorView(
        error: error,
        stackTrace: stack,
        onRetry: () =>
            ref.invalidate(konselingControllerProvider(widget.type)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
