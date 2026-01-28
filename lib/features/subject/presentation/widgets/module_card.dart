import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/domain/entities/module_entity.dart';
import 'package:gaia/features/subject/presentation/widgets/sub_module_card.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModuleCard extends HookConsumerWidget {
  const ModuleCard({super.key, required this.entity});
  final ModuleEntity entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = useState(false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 64.h,
                  width: 64.h,
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
                      height: 52.h,
                      width: 52.h,
                      child: Image.asset(
                        AssetsHelper.imgSubjectPlaceholder,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entity.title ?? '-',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: context.brand.textMain,
                        ),
                      ),
                      Text(
                        '${entity.subModuleCount} Sub Modul',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                IconButton(
                  tooltip: 'Besarkan',
                  iconSize: 44,
                  onPressed: () {
                    isOpen.value = !isOpen.value;
                  },
                  icon:  Icon(
                    Icons.arrow_drop_down,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isOpen.value,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entity.listSubModule?.length,
              itemBuilder: (context, index) => SubModuleCard(
                entity: entity.listSubModule![index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
