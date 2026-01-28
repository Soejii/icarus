import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/core/infrastructure/auth/auth_state_provider.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMenuButton extends ConsumerWidget {
  const ProfileMenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.path,
  });
  final IconData icon;
  final String label;
  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        switch (path) {
          case 'logout':
            ref.read(authStateProvider.notifier).logout();
            context.pushReplacementNamed(RouteName.login);
            break;
          case 'privacy-policy':
            await launchLink('https://sidigs.com/privacy-policy');
            break;
          default:
            context.pushNamed(path);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color.fromRGBO(0, 0, 0, 0.1),
                width: 1.w,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: context.brand.inactive,
              ),
              SizedBox(width: 20.w),
              Text(
                label,
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
      ),
    );
  }

  Future<void> launchLink(String link) async {
    final uri = Uri.parse(link);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
