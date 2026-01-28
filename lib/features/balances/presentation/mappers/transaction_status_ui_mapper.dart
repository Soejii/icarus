import 'package:flutter/material.dart';
import 'package:gaia/features/balances/domain/type/transaction_status.dart';

class TransactionStatusUIMapper {
  static String getDisplayText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return 'Berhasil';
      case TransactionStatus.pending:
        return 'Menunggu';
      case TransactionStatus.failed:
        return 'Gagal';
      case TransactionStatus.unknown:
        return 'Unknown';
    }
  }

  static Color getDisplayColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return const Color(0xFF27AE60);
      case TransactionStatus.pending:
        return const Color(0xFFF39C12);
      case TransactionStatus.failed:
        return const Color(0xFFE74C3C);
      case TransactionStatus.unknown:
        return const Color(0xFF95A5A6);
    }
  }

  static Color getBackgroundColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return const Color(0xFF27AE60).withValues(alpha:01);
      case TransactionStatus.pending:
        return const Color(0xFFF39C12).withValues(alpha:01);
      case TransactionStatus.failed:
        return const Color(0xFFE74C3C).withValues(alpha:01);
      case TransactionStatus.unknown:
        return const Color(0xFF95A5A6).withValues(alpha:01);
    }
  }
}
