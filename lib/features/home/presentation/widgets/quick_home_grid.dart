import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/home/presentation/widgets/quick_home_button.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';

class QuickHomeGrid extends StatelessWidget {
  const QuickHomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<QuickHomeButton> listHomeButton = [
      QuickHomeButton(
        path: RouteName.lainnya,
        label: 'Kehadiran',
        icon: AssetsHelper.imgHomeButtonKehadiran,
      ),
      QuickHomeButton(
        path: RouteName.listEdutainment,
        label: 'Edutainment',
        icon: AssetsHelper.imgHomeButtonEdutainment,
      ),
      QuickHomeButton(
        path: RouteName.absenceLetter,
        label: 'Surat Izin',
        icon: AssetsHelper.imgHomeButtonDiskusi,
      ),
      QuickHomeButton(
        path: RouteName.schedule,
        label: 'Jadwal Pelajaran',
        icon: AssetsHelper.imgHomeButtonJadwal,
      ),
      QuickHomeButton(
        path: RouteName.finance,
        label: 'Keuangan',
        icon: AssetsHelper.imgHomeButtonKeuangan,
      ),
      QuickHomeButton(
        path: RouteName.tahfidzTahsin,
        label: 'Tahfidz',
        icon: AssetsHelper.imgHomeButtonMapel,
      ),
      QuickHomeButton(
        path: RouteName.rapor,
        label: 'Rapor Murid',
        icon: AssetsHelper.imgHomeButtonMapel,
      ),
      QuickHomeButton(
        path: RouteName.lainnya,
        label: 'Semua Menu',
        icon: AssetsHelper.imgHomeButtonPengumuman,
      ),
    ];
    final topPadding = MediaQuery.of(context).padding.top;
    return Padding(
        padding: EdgeInsets.only(
          top: 145.h + topPadding,
          left: 20.w,
          right: 20.w,
          bottom: 16.h,
        ),
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
                  (e) => QuickHomeButton(
                      path: e.path, label: e.label, icon: e.icon),
                )
                .toList(),
          ),
        ));
  }
}
