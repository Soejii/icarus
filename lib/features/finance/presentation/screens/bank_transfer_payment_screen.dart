import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/bank_info_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_deadline_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/proof_upload_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/transfer_action_buttons_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class BankTransferPaymentScreen extends HookConsumerWidget {
  const BankTransferPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImage = useState<XFile?>(null);

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
          _CatatanTransferWidget(),
          SizedBox(height: 14.h),
          ProofUploadWidget(
            onImageSelected: (file) => selectedImage.value = file,
          ),
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
            onConfirm: () {
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
            onCancel: () => context.pop(),
          ),
        ],
      ),
    );
  }
}

class _CatatanTransferWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Catatan Transfer',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 7.h),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 56.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.circular(4.r),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(37, 0, 121, 173),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Text(
              'SPP Maret 2026 - Ahmad Fauzi',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
