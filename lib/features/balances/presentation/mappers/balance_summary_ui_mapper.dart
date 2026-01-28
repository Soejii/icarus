import 'package:flutter/material.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';

class BalanceSummaryUIMapper {
  static List<BalanceSummaryItem> getItems(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return [
          BalanceSummaryItem(
            label: 'Total Top Up',
            color: const Color(0xFF5AAF55),
          ),
          BalanceSummaryItem(
            label: 'Total Cash Out',
            color: const Color(0xFFFF7171),
          ),
          BalanceSummaryItem(
            label: 'Total Payment',
            color: const Color(0xFFFF7171),
          ),
        ];
      case BalanceType.savings:
        return [
          BalanceSummaryItem(
            label: 'Total Debit',
            color: const Color(0xFF5AAF55),
          ),
          BalanceSummaryItem(
            label: 'Total Kredit',
            color: const Color(0xFFFF7171),
          ),
        ];
    }
  }
}

class BalanceSummaryItem {
  final String label;
  final Color color;

  BalanceSummaryItem({
    required this.label,
    required this.color,
  });
}
