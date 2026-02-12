import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'performance_providers.g.dart';


@riverpod
class PerformanceTabIndex extends _$PerformanceTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}