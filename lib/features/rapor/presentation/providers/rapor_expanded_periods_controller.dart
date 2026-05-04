import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rapor_expanded_periods_controller.g.dart';

@riverpod
class RaporExpandedPeriods extends _$RaporExpandedPeriods {
  @override
  Set<int> build() => const <int>{};

  void toggle(int periodId) {
    final next = {...state};
    if (!next.add(periodId)) next.remove(periodId);
    state = next;
  }

  bool isExpanded(int periodId) => state.contains(periodId);
}
