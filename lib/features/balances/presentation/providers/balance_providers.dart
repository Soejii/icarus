import 'package:gaia/features/balances/data/datasources/balance_remote_data_source.dart';
import 'package:gaia/features/balances/data/balance_repository_impl.dart';
import 'package:gaia/features/balances/domain/balance_repository.dart';
import 'package:gaia/features/balances/domain/usecases/get_emoney_balance_usecase.dart';
import 'package:gaia/features/balances/domain/usecases/get_emoney_history_usecase.dart';
import 'package:gaia/features/balances/domain/usecases/get_savings_balance_usecase.dart';
import 'package:gaia/features/balances/domain/usecases/get_savings_history_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance_providers.g.dart';

@riverpod
BalanceRemoteDataSource balanceRemoteDataSource(Ref ref) {
  return BalanceRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
BalanceRepository balanceRepository(Ref ref) {
  return BalanceRepositoryImpl(
    ref.watch(balanceRemoteDataSourceProvider),
  );
}

@riverpod
class BalanceTabIndex extends _$BalanceTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}

@riverpod
GetEmoneyBalanceUsecase getEmoneyBalanceUsecase(Ref ref) {
  return GetEmoneyBalanceUsecase(
    ref.watch(balanceRepositoryProvider),
  );
}

@riverpod
GetEmoneyHistoryUsecase getEmoneyHistoryUsecase(Ref ref) {
  return GetEmoneyHistoryUsecase(
    ref.watch(balanceRepositoryProvider),
  );
}

@riverpod
GetSavingsBalanceUsecase getSavingsBalanceUsecase(Ref ref) {
  return GetSavingsBalanceUsecase(
    ref.watch(balanceRepositoryProvider),
  );
}

@riverpod
GetSavingsHistoryUsecase getSavingsHistoryUsecase(Ref ref) {
  return GetSavingsHistoryUsecase(
    ref.watch(balanceRepositoryProvider),
  );
}
