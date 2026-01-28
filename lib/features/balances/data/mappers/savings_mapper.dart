import 'package:gaia/features/balances/data/models/savings_model.dart';
import 'package:gaia/features/balances/domain/entities/savings_entity.dart';

extension SavingsMapper on SavingsModel {
  SavingsEntity toEntity() => SavingsEntity(
        name: name,
        cardId: cardId,
        saldoTabungan: saldoTopup,
        totalDebit: totalCashout,
        totalKredit: totalTopup
      );
}
