import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class BankInfoWidget extends StatelessWidget {
  const BankInfoWidget({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
  });

  final String bankName;
  final String accountNumber;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 105.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.account_balance,
                    color: context.brand.primary,
                    size: 32.w,
                  ),
                ),
              ),
              SizedBox(width: 13.w),
              Text(
                bankName,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
            ],
          ),
          SizedBox(height: 17.h),
          Text(
            'No. Rekening',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 7.h),
          copyableField(context, accountNumber),
          SizedBox(height: 14.h),
          Text(
            'Total Nominal Transfer',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 7.h),
          copyableField(context, amount),
        ],
      ),
    );
  }

  copyableField(BuildContext context, String value) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(37, 0, 121, 173),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: value));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil disalin'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(
                Icons.copy,
                color: context.brand.textSecondary,
                size: 20.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
