import 'package:flutter/material.dart';

enum BillStatusType {
  unpaid,
  paid,
  pending,
  installment,
  confirmed,
}

extension BillStatusLabel on BillStatusType {
  String get label => switch (this) {
        BillStatusType.unpaid => 'Belum Dibayar',
        BillStatusType.paid => 'Menunggu Konfirmasi',
        BillStatusType.pending => 'Menunggu Pembayaran',
        BillStatusType.installment => 'Sedang Diangsur',
        BillStatusType.confirmed => 'Sudah Dibayar',
      };

  Color get badgeColor => switch (this) {
        BillStatusType.unpaid => const Color(0xFFFF7171),
        BillStatusType.paid => const Color(0xFFFF7A00),
        BillStatusType.pending => const Color(0xFFFFA90F),
        BillStatusType.installment => const Color(0xFF752795),
        BillStatusType.confirmed => const Color(0xFF5AAF55),
      };

  Color get nominalColor => switch (this) {
        BillStatusType.unpaid => const Color(0xFFFF7171),
        BillStatusType.installment => const Color(0xFF009ADE),
        _ => const Color(0xFF009ADE),
      };
}
