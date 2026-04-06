import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';

class ScheduleChildSelector extends ConsumerWidget {
  const ScheduleChildSelector({super.key, required this.children});

  final List<ChildEntity> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedChildProvider);
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        itemCount: children.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, i) {
          final child = children[i];
          final isSelected = selected?.id == child.id;
          return GestureDetector(
            onTap: () =>
                ref.read(selectedChildProvider.notifier).select(child),
            child: childChip(context, child, isSelected),
          );
        },
      ),
    );
  }

  childChip(BuildContext context, ChildEntity child, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isSelected ? context.brand.mainGradient : null,
            border: isSelected
                ? null
                : Border.all(color: context.brand.primary, width: 1.5),
          ),
          padding: isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
          child: ClipOval(
            child: child.photo != null
                ? Image.network(
                    child.photo!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        initialsAvatar(context, child, isSelected),
                  )
                : initialsAvatar(context, child, isSelected),
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: 52.w,
          child: Text(
            child.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 10.sp,
              fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected
                  ? context.brand.primary
                  : context.brand.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  initialsAvatar(BuildContext context, ChildEntity child, bool isSelected) {
    final initials = child.displayName.isNotEmpty
        ? child.displayName[0].toUpperCase()
        : '?';
    return Container(
      color: isSelected
          ? Colors.white.withOpacity(0.3)
          : context.brand.primary.withOpacity(0.1),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: isSelected ? Colors.white : context.brand.primary,
        ),
      ),
    );
  }
}
