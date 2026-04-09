import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_providers.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_history_list_widget.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_tab_toggle_widget.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/create_absence_letter_form_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

const _demoItems = [
  AbsenceLetterEntity(
    type: 'Sakit',
    date: 'Selasa, 24 Juni 2020',
    description: 'Gejala Tipus/Tipes',
    isEditable: true,
  ),
  AbsenceLetterEntity(
    type: 'Izin',
    date: 'Senin, 23 Juni 2020',
    description: '-',
    isEditable: false,
  ),
];

class AbsenceLetterScreen extends ConsumerWidget {
  const AbsenceLetterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(absenceLetterTabIndexProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Surat Ijin',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          const AbsenceLetterTabToggleWidget(),
          Expanded(
            child: tabIndex == 0
                ? const CreateAbsenceLetterFormWidget()
                : const AbsenceLetterHistoryListWidget(items: _demoItems),
          ),
        ],
      ),
      bottomNavigationBar:
          tabIndex == 0 ? submitButton(context) : null,
    );
  }

  submitButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.invertedShadow,
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: context.brand.mainGradient,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: context.brand.shadow,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Buat Surat Izin',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
