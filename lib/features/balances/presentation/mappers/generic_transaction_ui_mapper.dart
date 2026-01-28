import 'package:flutter/material.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/features/balances/domain/type/transaction_type.dart';

class GenericTransactionUIMapper {
  static String getSavingsIconAsset(TransactionType type) {
    switch (type) {
      case TransactionType.topup:
        return AssetsHelper.icTopup;
      case TransactionType.cashout:
        return AssetsHelper.icCashout;
      case TransactionType.billPay:
      case TransactionType.canteenPay:
      case TransactionType.adminFee:
        return AssetsHelper.icCashout;
      case TransactionType.unknown:
        return AssetsHelper.icTopup;
    }
  }

  static String getSavingsDisplayText(TransactionType type) {
    switch (type) {
      case TransactionType.topup:
        return 'Top Up';
      case TransactionType.cashout:
        return 'Cashout';
      case TransactionType.billPay:
        return 'Bill Pay';
      case TransactionType.canteenPay:
        return 'Canteen Pay';
      case TransactionType.adminFee:
        return 'Fee Admin';
      case TransactionType.unknown:
        return 'Unknown';
    }
  }

  static Color getSavingsAmountColor(TransactionType type) {
    switch (type) {
      case TransactionType.topup:
        return const Color(0xFF5AAF55);
      case TransactionType.cashout:
      case TransactionType.billPay:
      case TransactionType.canteenPay:
      case TransactionType.adminFee:
        return const Color(0xFFFF7171);
      case TransactionType.unknown:
        return Colors.grey;
    }
  }
}