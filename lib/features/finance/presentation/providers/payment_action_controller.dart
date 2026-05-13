import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_action_controller.g.dart';

@riverpod
class PaymentActionController extends _$PaymentActionController {
  @override
  AsyncValue<Map<String, dynamic>> build() => const AsyncData({});

  Future<Map<String, dynamic>> createPayment(
      String slug, Map<String, dynamic> body) async {
    state = const AsyncLoading();
    final usecase = ref.read(createPaymentUsecaseProvider);
    final res = await usecase.call(slug, body);
    return res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (data) {
      state = AsyncData(data);
      return data;
    });
  }

  Future<void> submitTransfer({
    required int billTrxId,
    required int amount,
    String? notes,
  }) async {
    state = const AsyncLoading();
    final usecase = ref.read(submitTransferUsecaseProvider);
    final res = await usecase.call(
        billTrxId: billTrxId, amount: amount, notes: notes);
    res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (_) => state = const AsyncData({}));
  }

  Future<void> confirmTransfer({
    required int billTrxId,
    required String filePath,
  }) async {
    state = const AsyncLoading();
    final usecase = ref.read(confirmTransferUsecaseProvider);
    final res = await usecase.call(billTrxId: billTrxId, filePath: filePath);
    res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (_) => state = const AsyncData({}));
  }

  Future<void> cancelTransfer(int transferId) async {
    state = const AsyncLoading();
    final usecase = ref.read(cancelTransferUsecaseProvider);
    final res = await usecase.call(transferId);
    res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (_) => state = const AsyncData({}));
  }

  Future<Map<String, dynamic>> payMultiple(
    String paymentMethod,
    List<Map<String, dynamic>> bills,
  ) async {
    state = const AsyncLoading();
    final child = ref.read(selectedChildProvider);
    if (child == null) {
      state = const AsyncData({});
      return {};
    }
    final usecase = ref.read(payMultipleUsecaseProvider);
    final res = await usecase.call(paymentMethod, child.id, bills);
    return res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (data) {
      state = AsyncData(data);
      return data;
    });
  }

  Future<void> payWithEmoney({
    required int billTrxId,
    required int amount,
    String? notes,
  }) async {
    state = const AsyncLoading();
    final child = ref.read(selectedChildProvider);
    if (child == null) return;
    final usecase = ref.read(payWithEmoneyUsecaseProvider);
    final res = await usecase.call(
      studentId: child.id,
      billTrxId: billTrxId,
      amount: amount,
      notes: notes,
    );
    res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (_) => state = const AsyncData({}));
  }

  Future<Map<String, dynamic>> topupTransfer({
    required int amount,
    String? notes,
  }) async {
    state = const AsyncLoading();
    final child = ref.read(selectedChildProvider);
    if (child == null) {
      state = const AsyncData({});
      return {};
    }
    final usecase = ref.read(topupTransferUsecaseProvider);
    final res =
        await usecase.call(studentId: child.id, amount: amount, notes: notes);
    return res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (data) {
      state = AsyncData(data);
      return data;
    });
  }

  Future<void> confirmEmoneyTopup({
    required int emoneyId,
    required String filePath,
  }) async {
    state = const AsyncLoading();
    final usecase = ref.read(confirmEmoneyTopupUsecaseProvider);
    final res =
        await usecase.call(emoneyId: emoneyId, filePath: filePath);
    res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (_) => state = const AsyncData({}));
  }

  Future<void> editEmoneyConfirmation({
    required int emoneyId,
    required String filePath,
  }) async {
    state = const AsyncLoading();
    final usecase = ref.read(editEmoneyConfirmationUsecaseProvider);
    final res =
        await usecase.call(emoneyId: emoneyId, filePath: filePath);
    res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (_) => state = const AsyncData({}));
  }

  Future<void> cancelEmoneyTopup(int emoneyId) async {
    state = const AsyncLoading();
    final usecase = ref.read(cancelEmoneyTopupUsecaseProvider);
    final res = await usecase.call(emoneyId);
    res.fold((f) {
      state = AsyncError(f, StackTrace.current);
      throw f;
    }, (_) => state = const AsyncData({}));
  }
}
