import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/home/presentation/widgets/quick_home_button.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';

class QuickHomeGrid extends StatelessWidget {
  const QuickHomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<QuickHomeButton> listHomeButton = [
      QuickHomeButton(
        path: RouteName.subjectPicker,
        label: 'Mata Pelajaran',
        icon: AssetsHelper.imgHomeButtonMapel,
      ),
      QuickHomeButton(
        path: RouteName.chooseDiscussion,
        label: 'Diskusi',
        icon: AssetsHelper.imgHomeButtonDiskusi,
      ),
      QuickHomeButton(
        path: RouteName.attendance,
        label: 'Kehadiran',
        icon: AssetsHelper.imgHomeButtonKehadiran,
      ),
      QuickHomeButton(
        path: RouteName.schedule,
        label: 'Jadwal Pelajaran',
        icon: AssetsHelper.imgHomeButtonJadwal,
      ),
      QuickHomeButton(
        path: RouteName.listAnnouncement,
        label: 'Pengumuman',
        icon: AssetsHelper.imgHomeButtonPengumuman,
      ),
      QuickHomeButton(
        path: RouteName.listEdutainment,
        label: 'Edutainment',
        icon: AssetsHelper.imgHomeButtonEdutainment,
      ),
      QuickHomeButton(
        path: RouteName.balance,
        label: 'Keuangan',
        icon: AssetsHelper.imgHomeButtonKeuangan,
      ),
      QuickHomeButton(
        path: RouteName.lainnya,
        label: 'Lainnya',
        icon: AssetsHelper.imgHomeButtonEdutainment,
      ),
    ];
    final topPadding = MediaQuery.of(context).padding.top;
    return Positioned(
      left: 20.w,
      right: 20.w,
      top: 145.h + topPadding,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: context.brand.shadow,
        ),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 0.88,
          children: listHomeButton
              .map(
                (e) =>
                    QuickHomeButton(path: e.path, label: e.label, icon: e.icon),
              )
              .toList(),
        ),
      ),
    );
  }
}
