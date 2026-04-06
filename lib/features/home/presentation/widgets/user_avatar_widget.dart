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

    return Positioned(
      top: 85 + topPadding,
      left: 25.w,
      child: GestureDetector(
        onTap: () => context.pushNamed(RouteName.pilihAnakDidik),
        child: childrenAsync.when(
          data: (children) => stackedAvatars(context, children, selectedChild),
          loading: () => _loadingPlaceholder(),
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
    // Selected child first, then the rest (max 3 total)
    final ordered = [
      if (selectedChild != null) selectedChild,
      ...children.where((c) => c.id != selectedChild?.id),
    ].take(3).toList();

    const avatarSize = 56.0;
    const offset = 36.0; // how much each subsequent avatar shifts right

    final totalWidth = avatarSize + (ordered.length - 1) * offset;

    // Build children in reverse order so index 0 renders last (on top)
    final stackChildren = <Widget>[];
    for (int i = ordered.length - 1; i >= 0; i--) {
      stackChildren.add(
        Positioned(
          left: i * offset,
          child: _avatarCircle(context, ordered[i], isSelected: i == 0),
        ),
      );
    }

    return SizedBox(
      width: totalWidth,
      height: avatarSize,
      child: Stack(children: stackChildren),
    );
  }

  _loadingPlaceholder() {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(14),
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }

  _avatarCircle(
    BuildContext context,
    ChildEntity child, {
    required bool isSelected,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: child.photo != null
            ? Image.network(
                child.photo!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    _initialsAvatar(context, child, isSelected),
              )
            : _initialsAvatar(context, child, isSelected),
      ),
    );
  }

  _initialsAvatar(
    BuildContext context,
    ChildEntity child,
    bool isSelected,
  ) {
    final initials = child.displayName.isNotEmpty
        ? child.displayName[0].toUpperCase()
        : '?';
    return Container(
      color: isSelected
          ? context.brand.primary.withOpacity(0.2)
          : context.brand.primary.withOpacity(0.1),
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
