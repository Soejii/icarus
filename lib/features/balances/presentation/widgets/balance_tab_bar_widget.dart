import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/providers/balance_providers.dart';
import 'package:gaia/features/balances/presentation/mappers/balance_type_ui_mapper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceTabBarWidget extends ConsumerWidget {
  final TabController tabBarController;

  const BalanceTabBarWidget({
    super.key,
    required this.tabBarController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(balanceTabIndexProvider);

    return Container(
      height: 56.h,
      width: double.infinity,
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: TabBar(
        onTap: (index) => ref.read(balanceTabIndexProvider.notifier).set(index),
        controller: tabBarController,
        indicator: const BoxDecoration(color: Colors.transparent),
        tabs: balanceTypes.asMap().entries.map((entry) {
          final index = entry.key;
          final balanceType = entry.value;
          final isSelected = currentIndex == index;

          return Tab(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 28.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: isSelected ? context.brand.primary : Colors.white,
                border: Border.all(
                  width: 1.w,
                  color:
                      isSelected ? Colors.transparent : context.brand.primary,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Center(
                  child: Text(
                    BalanceTypeUIMapper.getDisplayName(balanceType),
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : context.brand.inactive,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
