import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/absence_letter/data/absence_letter_repository_impl.dart';
import 'package:icarus/features/absence_letter/data/datasource/absence_letter_remote_data_source.dart';
import 'package:icarus/features/absence_letter/domain/absence_letter_repository.dart';
import 'package:icarus/features/absence_letter/domain/usecase/get_absence_letter_history_usecase.dart';
import 'package:icarus/features/absence_letter/domain/usecase/submit_absence_letter_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'absence_letter_providers.g.dart';

final absenceLetterTabIndexProvider = StateProvider<int>((ref) => 0);

final absenceLetterHistoryTypeProvider = StateProvider<String>((ref) => 'all');

@riverpod
AbsenceLetterRemoteDataSource absenceLetterRemoteDataSource(Ref ref) {
  return AbsenceLetterRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
AbsenceLetterRepository absenceLetterRepository(Ref ref) {
  return AbsenceLetterRepositoryImpl(
    ref.watch(absenceLetterRemoteDataSourceProvider),
  );
}

@riverpod
GetAbsenceLetterHistoryUsecase getAbsenceLetterHistoryUsecase(Ref ref) {
  return GetAbsenceLetterHistoryUsecase(
    ref.watch(absenceLetterRepositoryProvider),
  );
}

@riverpod
SubmitAbsenceLetterUsecase submitAbsenceLetterUsecase(Ref ref) {
  return SubmitAbsenceLetterUsecase(ref.watch(absenceLetterRepositoryProvider));
}
