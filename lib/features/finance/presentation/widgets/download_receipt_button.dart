import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class DownloadReceiptButton extends StatelessWidget {
  const DownloadReceiptButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: context.brand.mainGradient,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: implement download receipt
            },
            icon: const Icon(Icons.download, color: Colors.white),
            label: Text(
              'Unduh E-Kwitansi',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
          ),
        ),
      ),
    );
  }
}
