import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class BillCheckboxItem extends StatelessWidget {
  const BillCheckboxItem({
    super.key,
    required this.amount,
    required this.billName,
    required this.date,
    required this.isChecked,
    required this.onChanged,
  });

  final String amount;
  final String billName;
  final String date;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color.fromRGBO(0, 0, 0, 0.10),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 25.w),
          IconButton(
            onPressed: () => onChanged(!isChecked),
            icon: Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank_rounded,
              color: isChecked ? context.brand.primary : context.brand.inactive,
              size: 28,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Rp ',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF7171),
                    ),
                    children: [
                      TextSpan(
                        text: amount,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF7171),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  billName,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textMain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
