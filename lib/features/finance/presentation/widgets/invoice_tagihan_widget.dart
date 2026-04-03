import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_status_badge.dart';

class InvoiceTagihanWidget extends StatelessWidget {
  const InvoiceTagihanWidget({
    super.key,
    required this.invoiceNumber,
    required this.status,
    required this.namaMurid,
    required this.nis,
    required this.jumlahPembayaran,
    required this.namaTagihan,
    required this.jatuhTempo,
    required this.metodePembayaran,
    required this.catatan,
    required this.isInstallment,
  });

  final String invoiceNumber;
  final BillStatusType status;
  final String namaMurid;
  final String nis;
  final String jumlahPembayaran;
  final String namaTagihan;
  final String jatuhTempo;
  final String metodePembayaran;
  final String catatan;
  final bool isInstallment;

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
          _buildField(context, 'Nama Murid', namaMurid),
          _buildField(context, 'NIS', nis),
          _buildField(
            context,
            'Jumlah Pembayaran',
            jumlahPembayaran,
            valueColor: status.nominalColor,
          ),
          _buildField(context, 'Nama Tagihan', namaTagihan),
          _buildField(context, 'Jatuh Tempo', jatuhTempo),
          _buildField(context, 'Metode Pembayaran', metodePembayaran),
          _buildField(context, 'Catatan', catatan),
          const Divider(height: 1),
          SizedBox(height: 12.h),
          _buildField(
            context,
            'Keterangan',
            isInstallment ? 'Bisa Diangsur' : 'Tidak Bisa Diangsur',
          ),
        ],
      ),
    );
  }

  Widget _buildField(
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
