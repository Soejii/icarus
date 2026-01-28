import 'balance_type.dart';

extension HistoryBalanceTypeExtension on BalanceType {
  String get historyTitle {
    switch (this) {
      case BalanceType.emoney:
        return 'Riwayat Transaksi E-Money';
      case BalanceType.savings:
        return 'Riwayat Transaksi Tabungan';
    }
  }
}
