import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/providers/bill_detail_controller.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/features/finance/presentation/widgets/download_receipt_button.dart';
import 'package:icarus/features/finance/presentation/widgets/invoice_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:intl/intl.dart';

class DetailPembayaranScreen extends ConsumerWidget {
  const DetailPembayaranScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(paymentFlowNotifierProvider).selectedBill;
    if (bill == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final detailAsync = ref.watch(billDetailControllerProvider(bill.id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Detail Pembayaran',
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
      body: detailAsync.when(
        loading: () => ListView(
          children: [
            SizedBox(height: 30.h),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
        error: (error, _) => Center(
          child: Text(
            error.toString(),
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
        ),
        data: (detail) => ListView(
          children: [
            SizedBox(height: 30.h),
            InvoiceWidget(
              invoiceNumber: detail.id.toString(),
              status: detail.status,
              namaMurid: detail.studentName,
              nis: detail.studentNis,
              jumlahPembayaran: formatRupiah(detail.paidAmount > 0 ? detail.paidAmount : detail.billAmount),
              namaTagihan: detail.billName,
              tanggalBayar: detail.payDate != null
                  ? DateFormat('d MMM yyyy', 'id_ID').format(detail.payDate!)
                  : '-',
              metodePembayaran: detail.payMethod ?? '-',
              catatan: detail.notes ?? '-',
            ),
            SizedBox(height: 74.h),
            const DownloadReceiptButton(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
