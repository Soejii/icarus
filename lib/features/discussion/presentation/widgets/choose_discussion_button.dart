import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class ChooseDiscussionButton extends ConsumerWidget {
  const ChooseDiscussionButton({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        if (index == 0) {
          context.pushNamed(RouteName.classDiscussion);
        } else {
          ref.read(detailSubjectTabIndexProvider.notifier).set(1);
          context.pushNamed(RouteName.subjectPicker);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.1),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(210, 239, 255, 1),
                      Color.fromRGBO(255, 255, 255, 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 32.h,
                    width: 24.w,
                    child: SvgPicture.asset(
                      AssetsHelper.icChooseDiscussion,
                      colorFilter: ColorFilter.mode(
                        index == 0
                            ? const Color.fromRGBO(53, 40, 161, 1)
                            : const Color.fromRGBO(78, 172, 220, 1),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 13.w),
              Text(
                index == 0 ? 'Diskusi Kelas' : 'Diskusi Mapel',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textMain,
                ),
              ),
              const Expanded(child: SizedBox()),
              Transform.rotate(
                angle: 180 * math.pi / 180,
                child:  Icon(
                  Icons.arrow_back_ios,
                  color: context.brand.textMain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
