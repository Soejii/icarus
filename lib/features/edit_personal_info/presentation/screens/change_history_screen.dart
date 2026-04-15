import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/domain/entities/change_request_entity.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/change_history_card_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ChangeHistoryScreen extends ConsumerWidget {
  const ChangeHistoryScreen({super.key});

  static final _dummyHistory = [
    ChangeRequestEntity(
      requestDate: DateTime(2025, 3, 4, 13, 0),
      updatedAt: DateTime(2025, 3, 4, 13, 5),
      status: ChangeRequestStatus.approved,
    ),
    ChangeRequestEntity(
      requestDate: DateTime(2025, 3, 1, 11, 0),
      updatedAt: DateTime(2025, 3, 1, 11, 5),
      status: ChangeRequestStatus.rejected,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = _dummyHistory;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const CustomAppBarWidget(
        title: 'Riwayat Perubahan Akun',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada riwayat perubahan.',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textSecondary,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
                    itemCount: items.length,
                    itemBuilder: (_, i) =>
                        ChangeHistoryCardWidget(entity: items[i]),
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: context.brand.invertedShadow,
            ),
            child: GestureDetector(
              onTap: () => context.pushNamed(RouteName.editPersonalInfo),
              child: Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: context.brand.mainGradient,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'Buat Pengajuan Perubahan',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
