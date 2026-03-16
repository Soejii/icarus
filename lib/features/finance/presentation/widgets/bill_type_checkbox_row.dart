import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class BillTypeCheckboxRow extends StatelessWidget {
  const BillTypeCheckboxRow({
    super.key,
    required this.typeName,
    required this.isChecked,
    required this.onChanged,
  });

  final String typeName;
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
          IconButton(
            onPressed: () => onChanged(!isChecked),
            icon: Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank_rounded,
              color: isChecked ? context.brand.primary : context.brand.inactive,
              size: 28,
            ),
          ),
          Text(
            typeName,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
        ],
      ),
    );
  }
}
