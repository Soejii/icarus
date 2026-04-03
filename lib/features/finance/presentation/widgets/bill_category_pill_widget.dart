import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';

class BillCategoryPillWidget extends StatelessWidget {
  const BillCategoryPillWidget({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: billCategories.asMap().entries.map((e) {
          final isSelected = selectedIndex == e.key;
          return GestureDetector(
            onTap: () => onTap(e.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 72,
              height: 22,
              decoration: BoxDecoration(
                gradient: isSelected
                    ? context.brand.mainGradient
                    : const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ),
                border: Border.all(
                  width: isSelected ? 0 : 1,
                  color: isSelected ? Colors.white : context.brand.primary,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Center(
                child: Text(
                  e.value.label,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : context.brand.primary,
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
