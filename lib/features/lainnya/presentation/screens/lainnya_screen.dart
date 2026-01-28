import 'package:flutter/material.dart';
import 'package:gaia/features/lainnya/presentation/widgets/route_button.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<RouteButton> listLainnyaButton = const [
      RouteButton(
        path: RouteName.subjectPicker,
        label: 'Mata Pelajaran',
      ),
      RouteButton(
        path: RouteName.chooseDiscussion,
        label: 'Diskusi',
      ),
      RouteButton(
        path: RouteName.attendance,
        label: 'Kehadiran',
      ),
      RouteButton(
        path: RouteName.schedule,
        label: 'Jadwal Pelajaran',
      ),
      RouteButton(
        path: RouteName.listAnnouncement,
        label: 'Pengumuman',
      ),
      RouteButton(
        path: RouteName.listEdutainment,
        label: 'Edutainment',
      ),
      RouteButton(
        path: RouteName.balance,
        label: 'Keuangan',
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Fitur Lainnya',
        leadingIcon: true,
      ),
      body: ListView(
        children: listLainnyaButton
            .map(
              (e) => RouteButton(label: e.label, path: e.path),
            )
            .toList(),
      ),
    );
  }
}
