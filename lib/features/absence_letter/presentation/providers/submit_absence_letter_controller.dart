import 'dart:async';

import 'package:icarus/features/absence_letter/domain/entities/submit_absence_letter_request.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submit_absence_letter_controller.g.dart';

@riverpod
class SubmitAbsenceLetterController extends _$SubmitAbsenceLetterController {
  @override
  FutureOr<void> build() {}

  Future<void> submit(SubmitAbsenceLetterRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(submitAbsenceLetterUsecaseProvider);
      final result = await usecase.submit(request);
      return result.fold((failure) => throw failure, (_) {});
    });
  }
}
