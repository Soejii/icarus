import 'package:flutter/material.dart';
import 'package:icarus/features/lainnya/presentation/widgets/route_button.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<RouteButton> listLainnyaButton = const [
      RouteButton(
        path: RouteName.listAnnouncement,
        label: 'Pengumuman',
      ),
      RouteButton(
        path: RouteName.listEdutainment,
        label: 'Edutainment',
      ),
      RouteButton(
        path: RouteName.chat,
        label: 'Chat',
      ),
      RouteButton(
        path: RouteName.notification,
        label: 'Notifikasi',
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
