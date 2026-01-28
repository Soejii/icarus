import 'package:gaia/features/balances/data/models/emoney_model.dart';
import 'package:gaia/features/balances/domain/entities/emoney_entity.dart';

extension EmoneyMapper on EmoneyModel {
  EmoneyEntity toEntity() => EmoneyEntity(
        name: name,
        cardId: cardId,
        saldoEmoney: saldoEmoney,
        totalTopup: totalTopup,
        totalPayment: totalPayment,
        totalCashout: totalCashout,
      );
}
