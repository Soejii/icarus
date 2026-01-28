import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gaia/features/schedule/domain/entities/schedule_entity.dart';
import 'package:gaia/features/schedule/presentation/widgets/schedule_filter_tabs.dart';
import 'package:gaia/features/schedule/presentation/widgets/schedule_content.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';

class ScheduleScreen extends HookConsumerWidget {
  const ScheduleScreen({super.key});

  static const List<String> _weekDays = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 6);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Jadwal Pelajaran',
        leadingIcon: false,
      ),
      body: Column(
        children: [
          ScheduleFilterTabs(
            tabController: tabController,
            weekDays: _weekDays,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: DayOfWeek.values.take(6).map((day) {
                return ScheduleContent(day: day);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
