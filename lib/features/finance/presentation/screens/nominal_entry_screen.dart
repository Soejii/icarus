import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_type_display_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/nominal_input_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_notes_input_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/student_info_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class NominalEntryScreen extends HookConsumerWidget {
  const NominalEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nominalController = useTextEditingController();
    final notesController = useTextEditingController();

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Nominal Angsur',
        leadingIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            const StudentInfoCard(),
            SizedBox(height: 16.h),
            const BillTypeDisplayWidget(
              label: 'Jenis Tagihan',
              value: 'SPP Maret 2026',
            ),
            SizedBox(height: 16.h),
            NominalInputWidget(controller: nominalController),
            SizedBox(height: 16.h),
            PaymentNotesInputWidget(controller: notesController),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: context.brand.invertedShadow,
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ElevatedButton(
                onPressed: () => context.pushNamed(RouteName.billPaymentDetail),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  'Lanjutkan',
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
      ),
    );
  }
}
