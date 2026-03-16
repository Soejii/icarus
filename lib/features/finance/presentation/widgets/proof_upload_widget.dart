import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class ProofUploadWidget extends StatelessWidget {
  const ProofUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // TODO: implement image picker
        },
        child: Container(
          height: 261.h,
          width: 336.w,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: context.brand.primary,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 40.w,
                color: context.brand.primary,
              ),
              SizedBox(height: 19.h),
              Text(
                'Upload Bukti Pembayaran',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
