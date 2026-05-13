import 'package:dio/dio.dart';
import 'package:icarus/features/finance/data/datasource/emoney_remote_data_source.dart';
import 'package:icarus/features/finance/data/mappers/emoney_mapper.dart';
import 'package:icarus/features/finance/domain/entities/emoney_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/emoney_transaction_entity.dart';
import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class EmoneyRepositoryImpl implements EmoneyRepository {
  final EmoneyRemoteDataSource _dataSource;
  EmoneyRepositoryImpl(this._dataSource);

  @override
  Future<Result<EmoneyDetailEntity>> getEmoneyDetail(int studentId) =>
      guard(() async {
        final model = await _dataSource.getEmoneyDetail(studentId);
        return model.toEntity();
      });

  @override
  Future<Result<List<EmoneyTransactionEntity>>> getEmoneyHistory(
          int studentId, {int limit = 10, int offset = 0}) =>
      guard(() async {
        final models = await _dataSource.getEmoneyHistory(studentId,
            limit: limit, offset: offset);
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Result<EmoneyTransactionEntity>> getEmoneyTransactionDetail(
          int id) =>
      guard(() async {
        final model = await _dataSource.getEmoneyTransactionDetail(id);
        return model.toEntity();
      });

  @override
  Future<Result<Map<String, dynamic>>> topupTransfer({
    required int studentId,
    required int amount,
    String? notes,
    String? filePath,
  }) =>
      guard(() async {
        final data = FormData.fromMap({
          'amount': amount.toString(),
          if (notes != null) 'notes': notes,
        });
        return _dataSource.topupTransfer(studentId, data);
      });

  @override
  Future<Result<void>> confirmTopup({
    required int emoneyId,
    required String filePath,
  }) =>
      guard(() async {
        final data = FormData.fromMap({
          'emoney_id': emoneyId.toString(),
          'evidence': await MultipartFile.fromFile(filePath),
        });
        await _dataSource.confirmTopup(data);
      });

  @override
  Future<Result<void>> editConfirmation({
    required int emoneyId,
    required String filePath,
  }) =>
      guard(() async {
        final data = FormData.fromMap({
          'emoney_id': emoneyId.toString(),
          'evidence': await MultipartFile.fromFile(filePath),
        });
        await _dataSource.editConfirmation(data);
      });

  @override
  Future<Result<void>> cancelTopup(int emoneyId) =>
      guard(() async {
        final data = FormData.fromMap({
          'emoney_id': emoneyId.toString(),
        });
        await _dataSource.cancelTopup(data);
      });
}
