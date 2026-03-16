import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class PaymentInstructionCard extends StatefulWidget {
  const PaymentInstructionCard({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  State<PaymentInstructionCard> createState() => _PaymentInstructionCardState();
}

class _PaymentInstructionCardState extends State<PaymentInstructionCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(229, 255, 252, 1),
                borderRadius: _isExpanded
                    ? BorderRadius.vertical(top: Radius.circular(8.r))
                    : BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: context.brand.textMain,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: context.brand.textMain,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(229, 255, 252, 1),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8.r)),
              ),
              child: Text(
                widget.description,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textMain,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
