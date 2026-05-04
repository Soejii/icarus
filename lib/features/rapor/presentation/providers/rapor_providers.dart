import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/rapor/data/datasource/rapor_file_data_source.dart';
import 'package:icarus/features/rapor/data/datasource/rapor_remote_data_source.dart';
import 'package:icarus/features/rapor/data/rapor_repository_impl.dart';
import 'package:icarus/features/rapor/domain/rapor_repository.dart';
import 'package:icarus/features/rapor/domain/usecase/get_rapor_history_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rapor_providers.g.dart';

@riverpod
RaporRemoteDataSource raporRemoteDataSource(Ref ref) =>
    RaporRemoteDataSource(ref.watch(dioProvider));

@riverpod
RaporFileDataSource raporFileDataSource(Ref ref) => RaporFileDataSource();

@riverpod
RaporRepository raporRepository(Ref ref) =>
    RaporRepositoryImpl(ref.watch(raporRemoteDataSourceProvider));

@riverpod
GetRaporHistoryUsecase getRaporHistoryUsecase(Ref ref) =>
    GetRaporHistoryUsecase(ref.watch(raporRepositoryProvider));
