import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/download_receipt_button.dart';
import 'package:icarus/features/finance/presentation/widgets/invoice_widget.dart';
import 'package:go_router/go_router.dart';

class DetailPembayaranScreen extends HookConsumerWidget {
  const DetailPembayaranScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ListView(
        children: [
          SizedBox(height: 30.h),
          const InvoiceWidget(
            invoiceNumber: '1024',
            status: BillStatusType.confirmed,
            namaMurid: 'Ahmad Fauzi',
            nis: '2024001234',
            jumlahPembayaran: 'Rp 500.000',
            namaTagihan: 'SPP Desember 2025',
            tanggalBayar: '15 Desember 2025',
            metodePembayaran: 'Transfer Bank',
            catatan: '-',
          ),
          SizedBox(height: 74.h),
          const DownloadReceiptButton(),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
