import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/va_bank_type.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_instruction_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class VaPaymentScreen extends HookConsumerWidget {
  const VaPaymentScreen({super.key, required this.bankType});

  final VaBankType bankType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const vaNumber = '8800012345678901';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBarWidget(
        title: 'Bayar Tagihan',
        leadingIcon: true,
      ),
      body: ListView(
        children: [
          // ── Gradient VA header ──────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            decoration: BoxDecoration(
              gradient: context.brand.mainGradient,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bankType.label,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timelapse_outlined,
                          color: Colors.amber[200],
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '23:59:59',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.amber[200],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'No. Virtual Account',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  vaNumber,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 14.h),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(
                      const ClipboardData(text: vaNumber),
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('No. VA berhasil disalin'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: context.brand.primary,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.copy_outlined,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Salin Nomor VA',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // ── Detail Pembayaran card ──────────────────────────────────
          sectionCard(
            context,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Pembayaran',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 14.h),
                detailRow(context, label: 'Kode Bank', value: bankType.bankCode),
                SizedBox(height: 10.h),
                detailRow(context, label: 'Biaya Admin', value: bankType.adminFee),
                SizedBox(height: 10.h),
                detailRow(context, label: 'Total Tagihan', value: 'Rp 502.500'),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // ── Cara Pembayaran ─────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Cara Pembayaran',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: context.brand.textMain,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          ...bankType.instructions.map(
            (instruction) => PaymentInstructionCard(
              title: instruction['title']!,
              description: instruction['description']!,
            ),
          ),

          SizedBox(height: 32.h),
        ],
      ),

      // ── Bottom actions ────────────────────────────────────────────
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: context.brand.invertedShadow,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: context.brand.mainGradient,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ElevatedButton(
                    onPressed: () =>
                        context.pushNamed(RouteName.pendingConfirmation),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Saya Sudah Bayar',
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
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  sectionCard(
    BuildContext context, {
    required EdgeInsetsGeometry padding,
    required Widget child,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: context.brand.shadow,
        ),
        child: child,
      ),
    );
  }

  detailRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textSecondary,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
        ),
      ],
    );
  }

