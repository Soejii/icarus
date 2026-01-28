import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool leadingIcon;
  final List<Widget>? actions;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(37, 119, 195, 0.15), // same RGBA
            offset: Offset(0, 10), // x = 0, y = 10
            blurRadius: 20, // blur amount
            spreadRadius: 0, // spread
          )
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: context.brand.primary,
        centerTitle: false,
        leading: leadingIcon
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.pop();
                },
              )
            : null,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
