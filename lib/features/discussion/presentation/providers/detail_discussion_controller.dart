import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/discussion/domain/entity/detail_discussion_entity.dart';
import 'package:gaia/features/discussion/presentation/providers/discussion_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_discussion_controller.g.dart';

@riverpod
class DetailDiscussionController extends _$DetailDiscussionController {
  Timer? _ttl; // for optional TTL keepAlive
  KeepAliveLink? _link;
  @override
  Future<DetailDiscussionEntity> build(int idDiscuss) {
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

  Future<DetailDiscussionEntity> _fetch() async {
    final useCase = ref.read(getDetailDiscussionUsecaseProvider);
    final res = await useCase.getDetailDiscussion(idDiscuss);

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }
}
