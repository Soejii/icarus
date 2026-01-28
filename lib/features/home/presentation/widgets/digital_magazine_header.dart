import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edutainment/presentation/providers/digital_magazine_controller.dart';
import 'package:icarus/features/home/presentation/widgets/digital_magazine_card.dart';

class DigitalMagazineHeader extends ConsumerWidget {
  const DigitalMagazineHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDigitalMagazine = ref.watch(digitalMagazineControllerProvider);
    return asyncDigitalMagazine.when(
      data: (data) {
        if (data.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Majalah Digital',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 205.h,
                width: double.infinity,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length > 5 ? 5 : data.length,
                  itemBuilder: (context, index) =>
                      DigitalMagazineCard(imgUrl: data[index].photo ?? ''),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
      error: (error, stackTrace) => Text('$error'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
