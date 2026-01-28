import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaia/app/theme/brand_assets.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/mappers/balance_type_ui_mapper.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_card_info_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BalanceCardWidget extends ConsumerWidget {
  final BalanceType type;

  const BalanceCardWidget({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradientColors = BalanceTypeUIMapper.getGradientColors(type);
        final brandAssets = ref.watch(brandAssetsProvider);
    final iconAsset = BalanceTypeUIMapper.getIconAsset(type);

    return Container(
      width: 296.w,
      height: 182.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16.h,
            right: 16.w,
            child: SvgPicture.asset(
              iconAsset,
              width: 24.w,
              height: 24.h,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              brandAssets.image('img_logo_transparent.png'),
              width: 120.h,
              height: 140.h,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: BalanceCardInfoWidget(type: type),
          ),
        ],
      ),
    );
  }
}

