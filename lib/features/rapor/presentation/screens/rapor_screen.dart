import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_period_entity.dart';
import 'package:icarus/features/rapor/presentation/providers/rapor_history_controller.dart';
import 'package:icarus/features/rapor/presentation/widgets/rapor_empty_state.dart';
import 'package:icarus/features/rapor/presentation/widgets/rapor_period_card.dart';
import 'package:icarus/features/rapor/presentation/widgets/rapor_period_skeleton.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class RaporScreen extends ConsumerStatefulWidget {
  const RaporScreen({super.key});

  @override
  ConsumerState<RaporScreen> createState() => _RaporScreenState();
}

class _RaporScreenState extends ConsumerState<RaporScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200.h) {
      ref.read(raporHistoryControllerProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(raporHistoryControllerProvider);
    final paged = historyAsync.valueOrNull;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 249, 252, 1),
      appBar: const CustomAppBarWidget(
        title: 'Rapor Murid',
        leadingIcon: true,
      ),
      body: historyAsync.when(
        data: (paged) {
          if (paged.error != null) {
            return BufferErrorView(
              error: paged.error!,
              onRetry: () =>
                  ref.read(raporHistoryControllerProvider.notifier).refresh(),
            );
          }
          if (paged.items.isEmpty) return const RaporEmptyState();
          return raporList(paged);
        },
        error: (error, stackTrace) {
          return BufferErrorView(
            error: error,
            stackTrace: stackTrace,
            onRetry: () =>
                ref.read(raporHistoryControllerProvider.notifier).refresh(),
          );
        },
        loading: () {
          if (paged != null &&
              !paged.isFirstLoading &&
              paged.items.isNotEmpty) {
            return raporList(paged);
          }
          return ListView(
            children: List.generate(
              3,
              (_) => const RaporPeriodSkeleton(),
            ),
          );
        },
      ),
    );
  }

  Widget raporList(Paged<RaporPeriodEntity> paged) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(raporHistoryControllerProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: 24.h),
        itemCount: paged.items.length + 1 + (paged.isMoreLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == 0) return SizedBox(height: 12.h);
          final itemIndex = index - 1;
          if (itemIndex >= paged.items.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return RaporPeriodCard(period: paged.items[itemIndex]);
        },
      ),
    );
  }
}
