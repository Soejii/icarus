import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/domain/entities/change_request_entity.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/change_history_tile_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/presentation/divider_card.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ChangeHistoryScreen extends ConsumerWidget {
  const ChangeHistoryScreen({super.key});

  static final _dummyHistory = [
    ChangeRequestEntity(
      tanggalPermintaan: DateTime(2025, 3, 4, 13, 0),
      tanggalUpdate: DateTime(2025, 3, 4, 13, 5),
      status: ChangeRequestStatus.disetujui,
    ),
    ChangeRequestEntity(
      tanggalPermintaan: DateTime(2025, 3, 1, 11, 0),
      tanggalUpdate: DateTime(2025, 3, 1, 11, 5),
      status: ChangeRequestStatus.ditolak,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Riwayat Perubahan Akun',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'TANGGAL\nPERMINTAAN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: context.brand.textMain,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'TANGGAL\nUPDATE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: context.brand.textMain,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'STATUS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: context.brand.textMain,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const DividerCard(),
          Expanded(
            child: ListView.separated(
              itemCount: _dummyHistory.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) =>
                  ChangeHistoryTileWidget(entity: _dummyHistory[i]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ElevatedButton(
                onPressed: () => context.goNamed(RouteName.editPersonalInfo),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Buat Perubahan Akun',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
