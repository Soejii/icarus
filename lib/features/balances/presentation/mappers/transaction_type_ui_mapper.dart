import 'package:flutter/material.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/features/balances/domain/type/transaction_type.dart';

class TransactionTypeUIMapper {
  static String getDisplayText(TransactionType type) {
    switch (type) {
      case TransactionType.topup:
        return 'Top Up';
      case TransactionType.cashout:
        return 'Cash Out';
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

  static String getIconAsset(TransactionType type) {
    switch (type) {
      case TransactionType.topup:
        return AssetsHelper.icTopup;
      case TransactionType.cashout:
      case TransactionType.billPay:
      case TransactionType.canteenPay:
      case TransactionType.adminFee:
        return AssetsHelper.icCashout;
      case TransactionType.unknown:
        return AssetsHelper.icTopup;
    }
  }

  static Color getAmountColor(TransactionType type) {
    switch (type) {
      case TransactionType.topup:
        return const Color(0xFF5AAF55);
      case TransactionType.cashout:
      case TransactionType.billPay:
      case TransactionType.canteenPay:
      case TransactionType.adminFee:
        return const Color(0xFFFF7171);
      case TransactionType.unknown:
        return const Color(0xFF95A5A6);
    }
  }

  static bool isIncome(TransactionType type) {
    return type == TransactionType.topup;
  }

  static bool isOutcome(TransactionType type) {
    return type == TransactionType.cashout ||
        type == TransactionType.billPay ||
        type == TransactionType.canteenPay ||
        type == TransactionType.adminFee;
  }
}
