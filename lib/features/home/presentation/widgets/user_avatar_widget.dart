import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';

class UserAvatarWidget extends ConsumerWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenAsync = ref.watch(childListControllerProvider);
    final selectedChild = ref.watch(selectedChildProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    final child = selectedChild ?? childrenAsync.valueOrNull?.firstOrNull;

    return Positioned(
      top: 85 + topPadding,
      left: 25.w,
      child: GestureDetector(
        onTap: () => context.pushNamed(RouteName.pilihAnakDidik),
        child: Container(
          width: 56.w,
          height: 56.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(2.r),
          child: ClipOval(
            child: child == null
                ? Padding(
                    padding: EdgeInsets.all(8.w),
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : child.photo != null
                    ? Image.network(
                        child.photo!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            initialsAvatar(context, child),
                      )
                    : initialsAvatar(context, child),
          ),
        ),
      ),
    );
  }

  initialsAvatar(BuildContext context, ChildEntity child) {
    final initials = child.name.isNotEmpty ? child.name[0].toUpperCase() : '?';
    return Container(
      color: context.brand.primary.withOpacity(0.15),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: context.brand.primary,
        ),
      ),
    );
  }
}
