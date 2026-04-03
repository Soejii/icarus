import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/proof_upload_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class BankTransferPaymentScreen extends HookConsumerWidget {
  const BankTransferPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImage = useState<XFile?>(null);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBarWidget(
        title: 'Bayar Tagihan',
        leadingIcon: true,
      ),
      body: ListView(
        children: [
          // ── Gradient amount header ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            decoration: BoxDecoration(
              gradient: context.brand.mainGradient,
            ),
            child: Column(
              children: [
                Text(
                  'Total Transfer',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Rp 502.500',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.amber[200],
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Pastikan transfer tepat hingga 3 digit terakhir',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // ── Rekening Tujuan card ────────────────────────────────────
          sectionCard(
            context,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rekening Tujuan',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: context.brand.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.account_balance_outlined,
                        color: context.brand.primary,
                        size: 22.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Bank Muamalat Indonesia',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.brand.textMain,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Divider(height: 1, color: const Color(0xFFE0E0E0)),
                SizedBox(height: 14.h),
                copyableRow(context,
                  label: 'No. Rekening',
                  value: '1234567890',
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

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
                detailRow(context,
                  label: 'Batas Pembayaran',
                  value: '15 Maret 2026',
                ),
                SizedBox(height: 10.h),
                detailRow(context,
                  label: 'ID Transaksi',
                  value: '#1024',
                ),
                SizedBox(height: 10.h),
                detailRow(context,
                  label: 'Catatan Transfer',
                  value: 'SPP Maret 2026 - Ahmad Fauzi',
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // ── Bukti Pembayaran card ───────────────────────────────────
          sectionCard(
            context,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bukti Pembayaran',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Upload foto bukti transfer Anda',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
                SizedBox(height: 14.h),
                ProofUploadWidget(
                  onImageSelected: (file) => selectedImage.value = file,
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // ── Disclaimer ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setelah melakukan konfirmasi, verifikasi pembayaran akan diproses dalam 15 menit dan selambatnya 1x24 jam.',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Sudah transfer via ATM/Mobile Banking? Klik konfirmasi setelah selesai.',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
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
                    onPressed: () {
                      if (selectedImage.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Silakan upload bukti pembayaran terlebih dahulu',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      context.pushNamed(RouteName.pendingConfirmation);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Saya Sudah Transfer',
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
                  'Batalkan Transaksi',
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

  copyableRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: context.brand.textSecondary,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: context.brand.textMain,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: value));
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Berhasil disalin'),
                duration: const Duration(seconds: 2),
                backgroundColor: context.brand.primary,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: context.brand.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Salin',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: context.brand.primary,
              ),
            ),
          ),
        ),
      ],
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
}
