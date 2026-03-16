import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';

class BillStatusBadge extends StatelessWidget {
  const BillStatusBadge({
    super.key,
    required this.status,
    this.onTap,
  });

  final BillStatusType status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: status.badgeColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                status.label,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
