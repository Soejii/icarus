import 'package:icarus/features/finance/domain/entities/emoney_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/emoney_transaction_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class EmoneyRepository {
  Future<Result<EmoneyDetailEntity>> getEmoneyDetail(int studentId);

  Future<Result<List<EmoneyTransactionEntity>>> getEmoneyHistory(
      int studentId, {int limit = 20, int offset = 0});

  Future<Result<EmoneyTransactionEntity>> getEmoneyTransactionDetail(int id);

  Future<Result<Map<String, dynamic>>> topupTransfer({
    required int studentId,
    required int amount,
    String? notes,
    String? filePath,
  });

  Future<Result<void>> confirmTopup({
    required int emoneyId,
    required String filePath,
  });

  Future<Result<void>> editConfirmation({
    required int emoneyId,
    required String filePath,
  });

  Future<Result<void>> cancelTopup(int emoneyId);
}
