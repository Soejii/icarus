import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/canteen_detail_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_action_button.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_summary_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/student_info_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class CanteenPaymentScreen extends ConsumerWidget {
  const CanteenPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Pembayaran Kantin',
        leadingIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            const StudentInfoCard(),
            SizedBox(height: 16.h),
            const CanteenDetailWidget(),
            SizedBox(height: 16.h),
            const PaymentSummaryWidget(
              items: [
                {'label': 'Nasi Goreng (1x)', 'value': 'Rp 15.000'},
                {'label': 'Es Teh Manis (2x)', 'value': 'Rp 10.000'},
                {'label': 'Roti Bakar (1x)', 'value': 'Rp 8.000'},
                {'label': 'Total', 'value': 'Rp 33.000'},
              ],
            ),
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
          child: PaymentActionButton(
            label: 'Bayar dengan E-Money',
            onPressed: () =>
                context.pushNamed(RouteName.transactionSuccess),
          ),
        ),
      ),
    );
  }
}
