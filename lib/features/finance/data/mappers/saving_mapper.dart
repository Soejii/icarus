import 'package:icarus/features/finance/data/models/saving_detail_model.dart';
import 'package:icarus/features/finance/data/models/saving_transaction_model.dart';
import 'package:icarus/features/finance/data/models/spending_limit_model.dart';
import 'package:icarus/features/finance/domain/entities/saving_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/domain/entities/spending_limit_entity.dart';
import 'package:icarus/shared/core/utils/rupiah_parser.dart';
import 'package:icarus/shared/core/utils/safe_date_parser.dart';

extension SavingDetailMapper on SavingDetailModel {
  SavingDetailEntity toEntity() {
    return SavingDetailEntity(
      studentName: name,
      schoolName: schoolName,
      cardId: cardId,
      saldoTopup: RupiahParser.toInt(saldoTopup),
      totalTopup: RupiahParser.toInt(totalTopup),
      totalCashout: RupiahParser.toInt(totalCashout),
      totalTransaction: RupiahParser.toInt(totalTransaction),
    );
  }
}

extension SavingTransactionMapper on SavingTransactionModel {
  SavingTransactionEntity toEntity() {
    return SavingTransactionEntity(
      id: id,
      amount: RupiahParser.toInt(amount),
      notes: notes,
      type: type,
      confirmed: confirmed == 1,
      transaction: transaction,
      date: SafeDateParser.parse(date),
      confirmationPhoto: confirmationPhoto,
      receivedBy: receivedBy,
      givenBy: givenBy,
    );
  }
}

extension SpendingLimitMapper on SpendingLimitModel {
  SpendingLimitEntity toEntity() {
    return SpendingLimitEntity(type: type, amount: amount);
  }
}
