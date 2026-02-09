import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icarus/app/theme/brand_palette.dart';
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
        decoration: BoxDecoration(gradient: context.brand.mainGradient),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              navigationButton(
                0,
                AssetsHelper.icHome,
                'Beranda',
                context,
                ref,
              ),
              navigationButton(
                1,
                AssetsHelper.icActivity,
                'Aktifitas',
                context,
                ref,
              ),
              navigationButton(
                2,
                AssetsHelper.icChat,
                'Chat',
                context,
                ref,
              ),
              navigationButton(
                3,
                AssetsHelper.icProfile,
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
    String icon,
    String label,
    BuildContext context,
    WidgetRef ref,
  ) {
    const _tabAnalyticsNames = <int, String>{
      0: 'home',
      1: 'activity',
      2: 'chat',
      3: 'profile',
    };

    final isSelected = index == shell.currentIndex;

    return GestureDetector(
      onTap: () async {
        if (isSelected) return;

        final analytics = ref.read(analyticsTrackerProvider);
        final tabName = _tabAnalyticsNames[index] ?? 'unknown';

        await analytics.trackScreen(tabName);

        shell.goBranch(index);
      },
      child: Container(
        height: 60.h,
        width: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color:
              index == shell.currentIndex ? Colors.white : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected
                ? ShaderMask(
                    shaderCallback: (bounds) =>
                        context.brand.mainGradient.createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: SizedBox(
                      height: 24.h,
                      width: 24.h,
                      child: SvgPicture.asset(
                        icon,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: SvgPicture.asset(
                      icon,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
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
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
