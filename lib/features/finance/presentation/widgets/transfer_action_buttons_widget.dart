import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class TransferActionButtonsWidget extends StatelessWidget {
  const TransferActionButtonsWidget({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: onConfirm,
            child: Container(
              height: 40.h,
              width: 245.w,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Center(
                child: Text(
                  'Saya Sudah Transfer',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 7.h),
        Center(
          child: GestureDetector(
            onTap: onCancel,
            child: Container(
              height: 40.h,
              width: 245.w,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: context.brand.green,
                ),
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Center(
                child: Text(
                  'Batalkan Transaksi',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.green,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
