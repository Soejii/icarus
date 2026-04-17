import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_personal_info_providers.g.dart';

@riverpod
class EditPersonalInfoTabIndex extends _$EditPersonalInfoTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}
