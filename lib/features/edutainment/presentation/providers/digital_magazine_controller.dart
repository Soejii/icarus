import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/edutainment/domain/entities/digital_magazine_entity.dart';
import 'package:icarus/features/edutainment/presentation/providers/edutainment_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'digital_magazine_controller.g.dart';

@riverpod
class DigitalMagazineController extends _$DigitalMagazineController {
  Timer? _ttl; // for optional TTL keepAlive
  KeepAliveLink? _link;

  @override
  Future<List<DigitalMagazineEntity>> build() {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());
    return _fetch();
  }

  Future<List<DigitalMagazineEntity>> _fetch() async {
    final uc = ref.read(getListDigitalMagazineUsecaseProvider);
    final either = await uc.getListDigitalMagazine();
    return either.fold((e) => throw e, (list) => list);
  }
}
