import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ChildSelectionScreen extends ConsumerWidget {
  const ChildSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenAsync = ref.watch(childListControllerProvider);
    final selectedChild = ref.watch(selectedChildProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Pilih Anak Didik',
        leadingIcon: true,
      ),
      body: childrenAsync.when(
        data: (children) => ListView.separated(
          itemCount: children.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            thickness: 1,
            color: context.brand.inactive.withOpacity(0.25),
            indent: 20.w,
            endIndent: 20.w,
          ),
          itemBuilder: (_, i) => childTile(
            context,
            ref,
            children[i],
            selectedChild?.id == children[i].id,
          ),
        ),
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(childListControllerProvider),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  childTile(
    BuildContext context,
    WidgetRef ref,
    ChildEntity child,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () {
        ref.read(selectedChildProvider.notifier).select(child);
        context.pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            childAvatar(context, child, isSelected),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    child.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.textMain,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    child.className != null
                        ? 'Kelas ${child.className} | ${child.nis}'
                        : child.nis,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: context.brand.primary,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }

  childAvatar(BuildContext context, ChildEntity child, bool isSelected) {
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? context.brand.primary
              : context.brand.inactive.withOpacity(0.5),
          width: isSelected ? 2.w : 1.w,
        ),
      ),
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
    );
  }

  initialsAvatar(BuildContext context, ChildEntity child, bool isSelected) {
    final initials = child.name.isNotEmpty ? child.name[0].toUpperCase() : '?';
    return Container(
      color: isSelected
          ? context.brand.primary.withOpacity(0.12)
          : context.brand.inactive.withOpacity(0.15),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: isSelected
              ? context.brand.primary
              : context.brand.textSecondary,
        ),
      ),
    );
  }
}
