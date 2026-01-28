import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/balances/domain/entities/savings_entity.dart';
import 'package:gaia/features/balances/presentation/providers/balance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'savings_controller.g.dart';

@riverpod
class SavingsController extends _$SavingsController {
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  Future<SavingsEntity> build() async {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());

    final usecase = ref.read(getSavingsBalanceUsecaseProvider);
    final res = await usecase.getSavingsBalance();
    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
