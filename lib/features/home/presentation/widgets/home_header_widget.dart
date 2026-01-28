import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/home/presentation/widgets/header_background.dart';
import 'package:icarus/features/home/presentation/widgets/quick_home_grid.dart';
import 'package:icarus/features/home/presentation/widgets/school_avatar_widget.dart';
import 'package:icarus/features/home/presentation/widgets/user_avatar_widget.dart';
import 'package:icarus/features/home/presentation/widgets/user_info_column.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 260.h + topPadding,
          child: const HeaderBackground(),
        ),
        Positioned(
          top: 25 + topPadding,
          left: 25.w,
          child: Text(
            'Selamat Datang',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 25 + topPadding,
          right: 25.w,
          child: IconButton(
            onPressed: () {
              context.pushNamed(RouteName.notification);
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        const UserAvatarWidget(),
        const UserInfoColumn(),
        const SchoolAvatarWidget(),
        const QuickHomeGrid(),
      ],
    );
  }
}
