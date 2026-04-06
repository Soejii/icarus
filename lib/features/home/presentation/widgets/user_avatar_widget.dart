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

  static const double _avatarSize = 56;
  static const double _offset = 36;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenAsync = ref.watch(childListControllerProvider);
    final selectedChild = ref.watch(selectedChildProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 85 + topPadding,
      left: 25.w,
      child: GestureDetector(
        onTap: () => context.pushNamed(RouteName.pilihAnakDidik),
        child: childrenAsync.when(
          data: (children) => stackedAvatars(context, children, selectedChild),
          loading: () => loadingPlaceholder(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ),
    );
  }

  stackedAvatars(
    BuildContext context,
    List<ChildEntity> children,
    ChildEntity? selectedChild,
  ) {
    final ordered = [
      if (selectedChild != null) selectedChild,
      ...children.where((c) => c.id != selectedChild?.id),
    ].take(3).toList();

    if (ordered.isEmpty) return loadingPlaceholder();

    final totalWidth = _avatarSize + (ordered.length - 1) * _offset;

    // Build in reverse so index 0 (selected) renders last = on top
    final stackChildren = <Widget>[];
    for (int i = ordered.length - 1; i >= 0; i--) {
      stackChildren.add(
        Positioned(
          left: (i * _offset).w,
          child: avatarCircle(context, ordered[i]),
        ),
      );
    }

    return SizedBox(
      width: totalWidth.w,
      height: _avatarSize.h,
      child: Stack(children: stackChildren),
    );
  }

  loadingPlaceholder() {
    return SizedBox(
      width: _avatarSize.w,
      height: _avatarSize.h,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(14.r),
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  avatarCircle(BuildContext context, ChildEntity child) {
    return Container(
      width: _avatarSize.w,
      height: _avatarSize.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(2.r),
      child: ClipOval(
        child: child.photo != null
            ? Image.network(
                child.photo!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => initialsAvatar(context, child),
              )
            : initialsAvatar(context, child),
      ),
    );
  }

  initialsAvatar(BuildContext context, ChildEntity child) {
    final initials =
        child.name.isNotEmpty ? child.name[0].toUpperCase() : '?';
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
