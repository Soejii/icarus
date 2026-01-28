import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class QuickSubjectButton extends StatelessWidget {
  const QuickSubjectButton({
    super.key,
    required this.id,
    required this.iconCode,
    required this.title,
  });

  final int id;
  final String iconCode;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          RouteName.detailSubject,
          pathParameters: {'id': id.toString()},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 96.h,
            width: 96.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(201, 238, 255, 1),
                  Color.fromRGBO(200, 238, 255, 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: SizedBox(
                height: 80.h,
                width: 80.h,
                child: Image.asset(
                  iconCode,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          )
        ],
      ),
    );
  }
}
