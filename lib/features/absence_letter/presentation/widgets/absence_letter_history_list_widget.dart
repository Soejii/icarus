import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_card.dart';

class AbsenceLetterHistoryListWidget extends StatelessWidget {
  const AbsenceLetterHistoryListWidget({
    super.key,
    required this.items,
  });

  final List<AbsenceLetterEntity> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'Belum ada surat izin.',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14.sp,
            color: context.brand.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
      itemCount: items.length,
      itemBuilder: (context, index) => AbsenceLetterCard(entity: items[index]),
    );
  }
}
