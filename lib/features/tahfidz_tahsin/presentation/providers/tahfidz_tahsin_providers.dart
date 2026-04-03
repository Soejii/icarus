import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tahfidz_tahsin_providers.g.dart';

@riverpod
class TahfidzTahsinTabIndex extends _$TahfidzTahsinTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}
