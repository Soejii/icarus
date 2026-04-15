import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/providers/edit_personal_info_providers.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class EditPersonalInfoTabBarWidget extends ConsumerWidget {
  const EditPersonalInfoTabBarWidget({super.key, required this.tabController});

  final TabController tabController;

  static const _tabLabels = ['Notifikasi WA', 'Ayah', 'Ibu', 'Wali'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(editPersonalInfoTabIndexProvider);
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        onTap: (i) => ref.read(editPersonalInfoTabIndexProvider.notifier).set(i),
        tabs: _tabLabels.asMap().entries.map((e) {
          final isSelected = currentIndex == e.key;
          return Tab(
            child: GradientText(
              e.value,
              gradient: isSelected
                  ? context.brand.mainGradient
                  : LinearGradient(
                      colors: [
                        context.brand.textSecondary,
                        context.brand.textSecondary,
                      ],
                    ),
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
