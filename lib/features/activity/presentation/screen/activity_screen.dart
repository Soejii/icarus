import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/features/activity/domain/type/activity_type.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/features/activity/presentation/providers/activity_providers.dart';
import 'package:gaia/features/activity/presentation/widgets/activity_tab_bar_widget.dart';
import 'package:gaia/features/activity/presentation/widgets/exam_content_widget.dart';
import 'package:gaia/features/activity/presentation/widgets/task_content_widget.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivityScreen extends HookConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: activityTypes.length,
      initialIndex: ref.watch(activityTabIndexProvider),
    );

    ref.listen(
      activityTabIndexProvider,
      (previous, next) {
        tabController.index = next;
      },
    );

    useEffect(
      () {
        void onChange() {
          if (!tabController.indexIsChanging) {
            ref
                .read(activityTabIndexProvider.notifier)
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
        title: 'Aktifitas',
        leadingIcon: false,
      ),
      body: Column(
        children: [
          ActivityTabBarWidget(tabController: tabController),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                ActivityExamContentWidget(type: ExamType.exam),
                ActivityExamContentWidget(type: ExamType.quiz),
                ActivityExamContentWidget(type: ExamType.cbt),
                ActivityTaskContentWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
