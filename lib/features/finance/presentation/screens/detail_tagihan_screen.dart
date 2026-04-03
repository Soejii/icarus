import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/installment_history_list_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/invoice_tagihan_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class DetailTagihanScreen extends HookConsumerWidget {
  const DetailTagihanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data
    const isInstallment = true;
    const status = BillStatusType.unpaid;

    final mockInstallments = <Map<String, dynamic>>[
      {
        'nominal': 'Rp 250.000',
        'date': '15 Januari 2026',
        'status': BillStatusType.confirmed,
      },
      {
        'nominal': 'Rp 250.000',
        'date': '15 Februari 2026',
        'status': BillStatusType.pending,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Detail Tagihan',
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
          const InvoiceTagihanWidget(
            invoiceNumber: '1024',
            status: status,
            namaMurid: 'Ahmad Fauzi',
            nis: '2024001234',
            jumlahPembayaran: 'Rp 500.000',
            namaTagihan: 'SPP Maret 2026',
            jatuhTempo: '15 Maret 2026',
            metodePembayaran: 'Transfer Bank',
            catatan: '-',
            isInstallment: isInstallment,
          ),
          SizedBox(height: 15.h),
          if (isInstallment)
            InstallmentHistoryListWidget(installments: mockInstallments),
          SizedBox(height: 30.h),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (isInstallment) {
            context.pushNamed(RouteName.nominalEntry);
          } else {
            context.pushNamed(RouteName.selectPayment);
          }
        },
        child: Container(
          height: 56.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: context.brand.mainGradient,
          ),
          child: Center(
            child: Text(
              'Bayar Tagihan',
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
    );
  }
}
