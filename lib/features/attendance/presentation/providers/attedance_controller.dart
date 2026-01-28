import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/features/attendance/presentation/providers/attedance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attedance_controller.g.dart';

@riverpod
class AttendanceController extends _$AttendanceController {
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  Future<List<AttendanceEntity>> build() async {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());

    final usecase = ref.read(getHistoryAttendanceUsecaseProvider);
    final result = await usecase.getAttendanceHistory();

    return result.fold(
      (failure) => throw failure,
      (entities) => entities,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}