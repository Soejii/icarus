import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ChildAccountInfoScreen extends ConsumerWidget {
  const ChildAccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenAsync = ref.watch(childListControllerProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const CustomAppBarWidget(
        title: 'Informasi Akun Anak',
        leadingIcon: true,
      ),
      body: childrenAsync.when(
        data: (children) => ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          children: [
            Text(
              'Pilih Siswa',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: context.brand.textMain,
              ),
            ),
            SizedBox(height: 16.h),
            ...children.map(
              (child) => childRow(context, child),
            ),
          ],
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

  childRow(BuildContext context, ChildEntity child) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Row(
        children: [
          childAvatar(context, child),
          SizedBox(width: 12.w),
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'NIS : ${child.nis}',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Status : Aktif',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            children: [
              actionButton(
                context,
                label: 'Ubah Data Siswa',
                isFilled: true,
                onTap: () => context.pushNamed(
                  RouteName.childChangeHistory,
                  extra: child,
                ),
              ),
              SizedBox(height: 6.h),
              actionButton(
                context,
                label: 'Detail Siswa',
                isFilled: false,
                onTap: () => context.pushNamed(
                  RouteName.childDetail,
                  extra: child,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  childAvatar(BuildContext context, ChildEntity child) {
    final initials = child.name.isNotEmpty ? child.name[0].toUpperCase() : '?';
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.brand.inactive.withOpacity(0.15),
      ),
      child: ClipOval(
        child: child.photo != null
            ? Image.network(
                child.photo!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: context.brand.textSecondary,
                    ),
                  ),
                ),
              )
            : Center(
                child: Icon(
                  Icons.person,
                  size: 24.sp,
                  color: context.brand.textSecondary,
                ),
              ),
      ),
    );
  }

  actionButton(
    BuildContext context, {
    required String label,
    required bool isFilled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          gradient: isFilled ? context.brand.mainGradient : null,
          border: isFilled
              ? null
              : Border.all(color: context.brand.textMain),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: isFilled ? Colors.white : context.brand.textMain,
          ),
        ),
      ),
    );
  }
}
