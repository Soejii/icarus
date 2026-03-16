import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/bank_info_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_deadline_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/proof_upload_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/transfer_action_buttons_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class BankTransferPaymentScreen extends HookConsumerWidget {
  const BankTransferPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Bayar Tagihan',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.brand.textMain,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_sharp,
            color: context.brand.textMain,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 17.h, bottom: 40.h),
        children: [
          const BankInfoWidget(
            bankName: 'Bank Muamalat Indonesia',
            accountNumber: '1234567890',
            amount: 'Rp 500.321',
          ),
          SizedBox(height: 17.h),
          const PaymentDeadlineWidget(
            deadline: '15 Maret 2026',
            transactionId: '1024',
          ),
          SizedBox(height: 14.h),
          const ProofUploadWidget(),
          SizedBox(height: 14.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catatan',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Setelah melakukan konfirmasi pembayaran, verifikasi pesanan anda akan kami proses dalam 15 menit dan selambatnya 1x24 jam.',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
                Divider(height: 24.h, color: context.brand.textMain),
                Text(
                  'Sudah transfer melalui ATM/internet/Mobile banking? Klik tombol dibawah untuk mengkonfirmasi. Sistem tidak memproses transaksi yang belum dikonfirmasi.',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textMain,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          TransferActionButtonsWidget(
            onConfirm: () =>
                context.pushNamed(RouteName.pendingConfirmation),
            onCancel: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
