import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';

class DigitalMagazineCard extends StatelessWidget {
  const DigitalMagazineCard({super.key, required this.imgUrl});
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () async {
          await showDialog(
            context: context,
            builder: (context) => majalahPopUp(imgUrl),
          );
        },
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: context.brand.shadow,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                AssetsHelper.imgAnnouncementPlaceholder,
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200.h,
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  majalahPopUp(String imgUrl) {
    return Dialog(
      child: InteractiveViewer(
        panEnabled: true,
        maxScale: 4.0,
        child: Image.network(
          imgUrl,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            AssetsHelper.imgAnnouncementPlaceholder,
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
