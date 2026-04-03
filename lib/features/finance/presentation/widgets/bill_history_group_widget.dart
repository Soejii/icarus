import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_item_card.dart';

class BillHistoryGroupWidget extends StatefulWidget {
  const BillHistoryGroupWidget({
    super.key,
    required this.year,
    required this.bills,
    this.onBillTap,
  });

  final String year;
  final List<Map<String, dynamic>> bills;
  final void Function(Map<String, dynamic> bill)? onBillTap;

  @override
  State<BillHistoryGroupWidget> createState() => _BillHistoryGroupWidgetState();
}

class _BillHistoryGroupWidgetState extends State<BillHistoryGroupWidget> {
  bool _collapsed = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _collapsed = !_collapsed),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            color: const Color.fromRGBO(252, 246, 229, 1),
            child: Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 20.w,
                top: 20.h,
                bottom: 20.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.year,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.textMain,
                    ),
                  ),
                  Icon(
                    _collapsed
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_up_outlined,
                    color: context.brand.textMain,
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_collapsed,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.bills.length,
            itemBuilder: (context, index) {
              final bill = widget.bills[index];
              return BillItemCard(
                nominal: bill['nominal'] as String,
                jenisPembayaran: bill['jenisPembayaran'] as String,
                date: bill['date'] as String,
                status: bill['status'] as BillStatusType,
                onPressed: () => widget.onBillTap?.call(bill),
              );
            },
          ),
        ),
      ],
    );
  }
}
