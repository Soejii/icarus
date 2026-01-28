import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:gaia/features/attendance/domain/type/attendance_type.dart';
import 'package:gaia/features/attendance/presentation/providers/attedance_providers.dart';
import 'package:gaia/features/attendance/presentation/widgets/attendance_tab_bar_widget.dart';
import 'package:gaia/features/attendance/presentation/widgets/attendance_history_widget.dart';
import 'package:gaia/features/attendance/presentation/widgets/attendance_calendar_widget.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';

class AttendanceScreen extends HookConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: attendanceTypes.length,
      initialIndex: ref.watch(attendanceTabIndexProvider),
    );

    useEffect(() {
      void onChange() {
        if (!tabController.indexIsChanging) {
          ref.read(attendanceTabIndexProvider.notifier).set(tabController.index);
        }
      }

      tabController.addListener(onChange);
      return () => tabController.removeListener(onChange);
    }, [tabController]);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Kehadiran",
        leadingIcon: true,
      ),
      body: Column(
        children: [
          AttendanceTabBarWidget(tabBarController: tabController),
          SizedBox(height: 20.h),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                AttendanceHistoryWidget(),
                AttendanceCalendarWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
