import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/performance/domain/types/performance_type.dart';
import 'package:icarus/features/performance/presentation/providers/performance_providers.dart';
import 'package:icarus/features/performance/presentation/screens/performance_content_widget.dart';
import 'package:icarus/features/performance/presentation/screens/performance_note_content_widget.dart';
import 'package:icarus/features/performance/presentation/widgets/performance_tab_bar_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class PerformanceScreen extends HookConsumerWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: performanceTypes.length,
      initialIndex: ref.watch(performanceTabIndexProvider),
    );

    ref.listen(
      performanceTabIndexProvider,
      (previous, next) {
        tabController.index = next;
      },
    );

    useEffect(
      () {
        void onChange() {
          if (!tabController.indexIsChanging) {
            ref
                .read(performanceTabIndexProvider.notifier)
                .set(tabController.index);
          }
        }

        tabController.addListener(
          () => onChange(),
        );
        return () => tabController.removeListener(onChange);
      },
      [tabController],
    );

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Performance Murid',
        leadingIcon: false,
      ),
      body: Column(
        children: [
          PerformanceTabBarWidget(tabController: tabController),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                PerformanceContentWidget(type: performanceTypes[0]),
                PerformanceContentWidget(type: performanceTypes[1]),
                PerformanceContentWidget(type: performanceTypes[2]),
                PerformanceNoteContentWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
