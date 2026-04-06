import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/features/schedule/presentation/widgets/schedule_content.dart';
import 'package:icarus/features/schedule/presentation/widgets/schedule_filter_tabs.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ScheduleScreen extends HookConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = DayOfWeek.weekDays;
    final tabController = useTabController(initialLength: days.length);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Jadwal Pelajaran',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          ScheduleFilterTabs(tabController: tabController),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: days.map((day) => ScheduleContent(day: day)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
