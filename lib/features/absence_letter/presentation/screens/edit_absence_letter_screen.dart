import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/create_absence_letter_form_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class EditAbsenceLetterScreen extends StatelessWidget {
  const EditAbsenceLetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Edit Surat Ijin',
        leadingIcon: true,
      ),
      body: const CreateAbsenceLetterFormWidget(
        initialReason: 'Sick',
        initialNotes: 'Gejala Tipus/Tipes',
        studentName: 'M. Khazil',
        studentClass: 'XII - RPL 1',
      ),
      bottomNavigationBar: saveButton(context),
    );
  }

  saveButton(BuildContext context) {
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
                'Edit Surat Izin',
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
