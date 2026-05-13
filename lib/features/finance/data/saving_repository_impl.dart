import 'package:icarus/features/finance/data/datasource/saving_remote_data_source.dart';
import 'package:icarus/features/finance/data/mappers/saving_mapper.dart';
import 'package:icarus/features/finance/domain/entities/saving_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/domain/entities/spending_limit_entity.dart';
import 'package:icarus/features/finance/domain/repositories/saving_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class SavingRepositoryImpl implements SavingRepository {
  final SavingRemoteDataSource _dataSource;
  SavingRepositoryImpl(this._dataSource);

  @override
  Future<Result<SavingDetailEntity>> getSavingDetail(int studentId) =>
      guard(() async {
        final model = await _dataSource.getSavingDetail(studentId);
        return model.toEntity();
      });

  @override
  Future<Result<List<SavingTransactionEntity>>> getSavingHistory(
          int studentId, {int limit = 10, int offset = 0}) =>
      guard(() async {
        final models = await _dataSource.getSavingHistory(studentId,
            limit: limit, offset: offset);
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Result<SavingTransactionEntity>> getSavingTransactionDetail(
          int id) =>
      guard(() async {
        final model = await _dataSource.getSavingTransactionDetail(id);
        return model.toEntity();
      });

  @override
  Future<Result<SpendingLimitEntity>> getSpendingLimit(int studentId) =>
      guard(() async {
        final model = await _dataSource.getSpendingLimit(studentId);
        return model.toEntity();
      });

  @override
  Future<Result<void>> setSpendingLimit(
          int studentId, String type, int? amount) =>
      guard(() => _dataSource.setSpendingLimit(
            studentId,
            {'type': type, if (amount != null) 'amount': amount},
          ));
}
