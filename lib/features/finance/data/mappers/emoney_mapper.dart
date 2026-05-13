import 'package:icarus/features/finance/data/models/emoney_detail_model.dart';
import 'package:icarus/features/finance/data/models/emoney_transaction_model.dart';
import 'package:icarus/features/finance/domain/entities/emoney_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/emoney_transaction_entity.dart';
import 'package:icarus/shared/core/utils/canteen_item_parser.dart';
import 'package:icarus/shared/core/utils/rupiah_parser.dart';
import 'package:icarus/shared/core/utils/safe_date_parser.dart';

extension EmoneyDetailMapper on EmoneyDetailModel {
  EmoneyDetailEntity toEntity() {
    return EmoneyDetailEntity(
      studentName: name,
      schoolName: schoolName,
      cardId: cardId,
      saldoEmoney: RupiahParser.toInt(saldoEmoney),
      totalTopup: RupiahParser.toInt(totalTopup),
      totalPayment: RupiahParser.toInt(totalPayment),
      totalCashout: RupiahParser.toInt(totalCashout),
      totalTransaction: RupiahParser.toInt(totalTransaction),
    );
  }
}

extension EmoneyTransactionMapper on EmoneyTransactionModel {
  EmoneyTransactionEntity toEntity() {
    return EmoneyTransactionEntity(
      id: id,
      amount: RupiahParser.toInt(amount),
      isDebit: RupiahParser.isDebit(amount),
      notes: notes,
      type: type,
      transaction: transaction,
      status: status,
      date: SafeDateParser.parse(date),
      confirmationPhoto: confirmationPhoto,
      merchantName: merchantName,
      canteenItems: CanteenItemParser.parse(listItem),
      studentName: student?.name,
      studentNis: student?.nis,
    );
  }
}
