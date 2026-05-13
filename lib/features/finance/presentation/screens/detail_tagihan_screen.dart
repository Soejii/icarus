import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/providers/bill_detail_controller.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/features/finance/presentation/widgets/installment_history_list_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/invoice_tagihan_widget.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DetailTagihanScreen extends ConsumerWidget {
  const DetailTagihanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(paymentFlowNotifierProvider);
    final bill = flow.selectedBill;

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
        data: (detail) {
          final installments = detail.installmentsConfirmed
              .map(
                (inst) => {
                  'nominal': formatRupiah(inst.payAmount),
                  'date': inst.payDate != null
                      ? DateFormat('d MMM yyyy', 'id_ID').format(inst.payDate!)
                      : '-',
                  'status': inst.status,
                },
              )
              .toList();

          return ListView(
            children: [
              SizedBox(height: 30.h),
              InvoiceTagihanWidget(
                invoiceNumber: detail.id.toString(),
                status: detail.status,
                namaMurid: detail.studentName,
                nis: detail.studentNis,
                jumlahPembayaran: formatRupiah(detail.billAmount),
                namaTagihan: detail.billName,
                jatuhTempo: detail.endDate != null
                    ? DateFormat('d MMM yyyy', 'id_ID').format(detail.endDate!)
                    : '-',
                metodePembayaran: detail.payMethod ?? 'Belum Dipilih',
                catatan: detail.notes ?? '-',
                isInstallment: detail.isInstallment,
              ),
              SizedBox(height: 15.h),
              if (detail.isInstallment)
                InstallmentHistoryListWidget(installments: installments),
              SizedBox(height: 30.h),
            ],
          );
        },
      ),
      bottomNavigationBar: detailAsync.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (detail) => GestureDetector(
          onTap: () {
            if (detail.isInstallment) {
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
      ),
    );
  }
}
