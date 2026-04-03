import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_status_badge.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({
    super.key,
    required this.invoiceNumber,
    required this.status,
    required this.namaMurid,
    required this.nis,
    required this.jumlahPembayaran,
    required this.namaTagihan,
    required this.tanggalBayar,
    required this.metodePembayaran,
    required this.catatan,
  });

  final String invoiceNumber;
  final BillStatusType status;
  final String namaMurid;
  final String nis;
  final String jumlahPembayaran;
  final String namaTagihan;
  final String tanggalBayar;
  final String metodePembayaran;
  final String catatan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Invoice No : #$invoiceNumber',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
              ),
              BillStatusBadge(status: status),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1),
          SizedBox(height: 12.h),
          field(context, 'Nama Murid', namaMurid),
          field(context, 'NIS', nis),
          field(
            context,
            'Jumlah Pembayaran',
            jumlahPembayaran,
            valueColor: status.nominalColor,
          ),
          field(context, 'Nama Tagihan', namaTagihan),
          field(context, 'Tanggal Bayar', tanggalBayar),
          field(context, 'Metode Pembayaran', metodePembayaran),
          field(context, 'Catatan', catatan),
        ],
      ),
    );
  }

  field(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40.h),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Column(
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
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: valueColor ?? context.brand.textMain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
