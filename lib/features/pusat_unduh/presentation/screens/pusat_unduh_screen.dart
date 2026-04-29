import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/pusat_unduh/presentation/providers/pusat_unduh_controller.dart';
import 'package:icarus/features/pusat_unduh/presentation/widgets/pusat_unduh_card.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class PusatUnduhScreen extends ConsumerStatefulWidget {
  const PusatUnduhScreen({super.key});

  @override
  ConsumerState<PusatUnduhScreen> createState() => _PusatUnduhScreenState();
}

class _PusatUnduhScreenState extends ConsumerState<PusatUnduhScreen> {
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
        _scrollController.position.maxScrollExtent - 200.h) {
      ref.read(pusatUnduhControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(pusatUnduhControllerProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Pusat Unduh',
        leadingIcon: true,
      ),
      body: asyncState.when(
        data: (data) {
          if (data.items.isEmpty) {
            return const DataNotFoundScreen(dataType: 'Pusat Unduh');
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(pusatUnduhControllerProvider.notifier).refresh(),
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: data.items.length + (data.isMoreLoading ? 1 : 0),
              itemBuilder: (_, i) {
                if (i >= data.items.length) {
                  return Padding(
                    padding: EdgeInsets.all(16.r),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return PusatUnduhCard(entity: data.items[i]);
              },
            ),
          );
        },
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(pusatUnduhControllerProvider),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
