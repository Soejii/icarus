import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/balances/domain/entities/emoney_entity.dart';
import 'package:gaia/features/balances/presentation/providers/balance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoney_controller.g.dart';

@riverpod
class EmoneyController extends _$EmoneyController {
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  Future<EmoneyEntity> build() async {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());

    final usecase = ref.read(getEmoneyBalanceUsecaseProvider);
    final res = await usecase.getEmoneyBalance();
    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
