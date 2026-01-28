enum BalanceType {
  savings,
  emoney,
}

extension BalanceTypeExtension on BalanceType {
  String get displayName {
    switch (this) {
      case BalanceType.savings:
        return 'Tabungan';
      case BalanceType.emoney:
        return 'E-money';
    }
  }
}

const List<BalanceType> balanceTypes = [
  BalanceType.savings,
  BalanceType.emoney,
];
