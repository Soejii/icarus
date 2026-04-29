import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/sentra/presentation/providers/sentra_controller.dart';
import 'package:icarus/features/sentra/presentation/widgets/sentra_card.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ListSentraScreen extends ConsumerStatefulWidget {
  const ListSentraScreen({super.key});

  @override
  ConsumerState<ListSentraScreen> createState() => _ListSentraScreenState();
}

class _ListSentraScreenState extends ConsumerState<ListSentraScreen> {
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
      ref.read(sentraControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(sentraControllerProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Sentra',
        leadingIcon: true,
      ),
      body: asyncState.when(
        data: (data) {
          if (data.items.isEmpty) {
            return const DataNotFoundScreen(dataType: 'Sentra');
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(sentraControllerProvider.notifier).refresh(),
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
                return SentraCard(entity: data.items[i]);
              },
            ),
          );
        },
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(sentraControllerProvider),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
