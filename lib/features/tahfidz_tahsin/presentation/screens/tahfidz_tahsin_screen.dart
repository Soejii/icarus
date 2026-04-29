import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/providers/tahfidz_controller.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/providers/tahfidz_tahsin_providers.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/providers/tahsin_controller.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/widgets/tahfidz_record_card.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/widgets/tahfidz_tahsin_tab_toggle.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/widgets/tahsin_record_card.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class TahfidzTahsinScreen extends ConsumerStatefulWidget {
  const TahfidzTahsinScreen({super.key});

  @override
  ConsumerState<TahfidzTahsinScreen> createState() =>
      TahfidzTahsinScreenState();
}

class TahfidzTahsinScreenState extends ConsumerState<TahfidzTahsinScreen> {
  final tahfidzScrollController = ScrollController();
  final tahsinScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tahfidzScrollController.addListener(onTahfidzScroll);
    tahsinScrollController.addListener(onTahsinScroll);
  }

  @override
  void dispose() {
    tahfidzScrollController.dispose();
    tahsinScrollController.dispose();
    super.dispose();
  }

  void onTahfidzScroll() {
    if (tahfidzScrollController.position.pixels >=
        tahfidzScrollController.position.maxScrollExtent - 200.h) {
      ref.read(tahfidzControllerProvider.notifier).loadMore();
    }
  }

  void onTahsinScroll() {
    if (tahsinScrollController.position.pixels >=
        tahsinScrollController.position.maxScrollExtent - 200.h) {
      ref.read(tahsinControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = ref.watch(tahfidzTahsinTabIndexProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Tahfidz/Tahsin',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          const TahfidzTahsinTabToggle(),
          Expanded(
            child: tabIndex == 0 ? tahfidzList(context) : tahsinList(context),
          ),
        ],
      ),
    );
  }

  monthHeader(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 4.h),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: context.brand.textSecondary,
        ),
      ),
    );
  }

  tahfidzList(BuildContext context) {
    final asyncState = ref.watch(tahfidzControllerProvider);
    return asyncState.when(
      data: (data) {
        if (data.items.isEmpty) {
          return const DataNotFoundScreen(dataType: 'Tahfidz');
        }
        return RefreshIndicator(
          onRefresh: () =>
              ref.read(tahfidzControllerProvider.notifier).refresh(),
          child: ListView.builder(
            controller: tahfidzScrollController,
            padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
            itemCount: data.items.length + (data.isMoreLoading ? 1 : 0),
            itemBuilder: (_, index) {
              if (index >= data.items.length) {
                return loadingMoreIndicator();
              }
              return tahfidzRecordItem(context, data.items, index);
            },
          ),
        );
      },
      error: (error, stack) => BufferErrorView(
        error: error,
        stackTrace: stack,
        onRetry: () => ref.invalidate(tahfidzControllerProvider),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  tahfidzRecordItem(
    BuildContext context,
    List<TahfidzRecord> records,
    int index,
  ) {
    final record = records[index];
    final showMonth =
        index == 0 || records[index - 1].monthLabel != record.monthLabel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showMonth) monthHeader(context, record.monthLabel),
        TahfidzRecordCard(record: record),
      ],
    );
  }

  tahsinList(BuildContext context) {
    final asyncState = ref.watch(tahsinControllerProvider);
    return asyncState.when(
      data: (data) {
        if (data.items.isEmpty) {
          return const DataNotFoundScreen(dataType: 'Tahsin');
        }
        return RefreshIndicator(
          onRefresh: () =>
              ref.read(tahsinControllerProvider.notifier).refresh(),
          child: ListView.builder(
            controller: tahsinScrollController,
            padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
            itemCount: data.items.length + (data.isMoreLoading ? 1 : 0),
            itemBuilder: (_, index) {
              if (index >= data.items.length) {
                return loadingMoreIndicator();
              }
              return tahsinRecordItem(context, data.items, index);
            },
          ),
        );
      },
      error: (error, stack) => BufferErrorView(
        error: error,
        stackTrace: stack,
        onRetry: () => ref.invalidate(tahsinControllerProvider),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  tahsinRecordItem(
    BuildContext context,
    List<TahsinRecord> records,
    int index,
  ) {
    final record = records[index];
    final showMonth =
        index == 0 || records[index - 1].monthLabel != record.monthLabel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showMonth) monthHeader(context, record.monthLabel),
        TahsinRecordCard(record: record),
      ],
    );
  }

  loadingMoreIndicator() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
