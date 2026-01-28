import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';

class DetailEdutainmentImage extends StatelessWidget {
  const DetailEdutainmentImage({
    super.key,
    required this.imgUrl,
  });
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        child: Image.network(
          imgUrl,
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
    );
  }
}
