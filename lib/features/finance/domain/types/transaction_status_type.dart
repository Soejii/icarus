import 'package:flutter/material.dart';

enum TransactionStatusType {
  berhasil,
  gagal,
  menungguPembayaran,
  menungguKonfirmasi,
}

extension TransactionStatusName on TransactionStatusType {
  String get label => switch (this) {
        TransactionStatusType.berhasil => 'Berhasil',
        TransactionStatusType.gagal => 'Gagal',
        TransactionStatusType.menungguPembayaran => 'Menunggu Pembayaran',
        TransactionStatusType.menungguKonfirmasi => 'Menunggu Konfirmasi',
      };

  Color get color => switch (this) {
        TransactionStatusType.berhasil => const Color(0xFF5AAF55),
        TransactionStatusType.gagal => const Color(0xFFFF7171),
        TransactionStatusType.menungguPembayaran => const Color(0xFFFF9800),
        TransactionStatusType.menungguKonfirmasi => const Color(0xFF2196F3),
      };
}
