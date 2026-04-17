import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_child_info_providers.g.dart';

@riverpod
class EditChildInfoTabIndex extends _$EditChildInfoTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}
