import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/constant/app_colors.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:icarus/shared/core/infrastructure/analytics/analytics_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class BottomNavigationShell extends ConsumerWidget {
  const BottomNavigationShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: shell, // shows current branch’s Navigator
      bottomNavigationBar: Container(
        height: 80.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              navigationButton(
                0,
                'Beranda',
                context,
                ref,
              ),
              navigationButton(
                1,
                'Performance',
                context,
                ref,
              ),
              navigationButton(
                2,
                'Chat',
                context,
                ref,
              ),
              navigationButton(
                3,
                'Profile',
                context,
                ref,
              ),
            ],
          ),
        ),
      ),
    );
  }

  navigationButton(
    int index,
    String label,
    BuildContext context,
    WidgetRef ref,
  ) {
    const _tabAnalyticsNames = <int, String>{
      0: 'home',
      1: 'performance',
      2: 'chat',
      3: 'profile',
    };

    final isSelected = index == shell.currentIndex;

    final listActiveIcon = [
      AssetsHelper.icHomeActive,
      AssetsHelper.icPerformanceActive,
      AssetsHelper.icChatActive,
      AssetsHelper.icProfileActive,
    ];

    final listInactiveIcon = [
      AssetsHelper.icHomeInactive,
      AssetsHelper.icPerformanceInactive,
      AssetsHelper.icChatInactive,
      AssetsHelper.icProfileInactive,
    ];

    String icon;

    if (isSelected) {
      icon = listActiveIcon[index];
    } else {
      icon = listInactiveIcon[index];
    }

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          if (isSelected) return;

          final analytics = ref.read(analyticsTrackerProvider);
          final tabName = _tabAnalyticsNames[index] ?? 'unknown';

          await analytics.trackScreen(tabName);

          shell.goBranch(index);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected
                ? SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: SvgPicture.asset(
                      icon,
                    ),
                  )
                : SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: SvgPicture.asset(
                      icon,
                    ),
                  ),
            SizedBox(height: 4.h),
            isSelected
                ? GradientText(
                    label,
                    gradient: context.brand.mainGradient,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inactiveColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
