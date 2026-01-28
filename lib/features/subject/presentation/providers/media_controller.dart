import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/subject/domain/entities/media_entity.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_controller.g.dart';

@riverpod
class MediaController extends _$MediaController {
  Timer? _ttl; // for optional TTL keepAlive
  KeepAliveLink? _link;
  @override
  Future<List<MediaEntity>> build(int idSubject) {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());
    return _fetch(idSubject);
  }

  Future<List<MediaEntity>> _fetch(int idSubject) async {
    final useCase = ref.read(getListMediaUsecaseProvider);
    final res = await useCase.getListMedia(idSubject);

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }

  Future<void> refresh(int idSubject) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(idSubject));
  }
}
