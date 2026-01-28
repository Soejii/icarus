import 'package:gaia/features/balances/data/datasources/balance_remote_data_source.dart';
import 'package:gaia/features/balances/data/mappers/emoney_mapper.dart';
import 'package:gaia/features/balances/data/mappers/emoney_history_mapper.dart';
import 'package:gaia/features/balances/data/mappers/savings_mapper.dart';
import 'package:gaia/features/balances/data/mappers/savings_history_mapper.dart';
import 'package:gaia/features/balances/domain/balance_repository.dart';
import 'package:gaia/features/balances/domain/entities/emoney_entity.dart';
import 'package:gaia/features/balances/domain/entities/emoney_history_entity.dart';
import 'package:gaia/features/balances/domain/entities/savings_entity.dart';
import 'package:gaia/features/balances/domain/entities/savings_history_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceRemoteDataSource _remoteDataSource;

  BalanceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<EmoneyEntity>> getEmoneyBalance() => guard(() async {
        final model = await _remoteDataSource.getEmoneyBalance();
        return model.toEntity();
      });

  @override
  Future<Result<SavingsEntity>> getSavingsBalance() => guard(() async {
        final model = await _remoteDataSource.getSavingsBalance();
        return model.toEntity();
      });

  @override
  Future<Result<List<EmoneyHistoryEntity>>> getEmoneyHistory({int? page}) =>
      guard(
        () async {
          final models = await _remoteDataSource.getEmoneyHistory(page: page);
          return models.map((model) => model.toEntity()).toList();
        },
      );

  @override
  Future<Result<List<SavingsHistoryEntity>>> getSavingsHistory({int? page}) =>
      guard(
        () async {
          final models = await _remoteDataSource.getSavingsHistory(page: page);
          return models.map((model) => model.toEntity()).toList();
        },
      );
}
