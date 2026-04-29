import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/features/sentra/presentation/widgets/detail_sentra_field.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class DetailSentraScreen extends StatelessWidget {
  const DetailSentraScreen({super.key, required this.entity});

  final SentraEntity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Detail Sentra',
        leadingIcon: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          headerCard(context, entity),
          SizedBox(height: 12.h),
          sectionCard(
            context,
            title: 'Keterangan',
            body: entity.note,
          ),
          SizedBox(height: 12.h),
          sectionCard(
            context,
            title: 'Deskripsi',
            body: entity.description,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  headerCard(BuildContext context, SentraEntity entity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sentra',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: context.brand.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      entity.name,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: context.brand.textMain,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              scoreChip(context, entity.score),
            ],
          ),
          SizedBox(height: 14.h),
          Container(height: 1.h, color: context.brand.inactive),
          SizedBox(height: 14.h),
          DetailSentraField(
            icon: Icons.event_outlined,
            label: 'Tanggal',
            value: entity.date,
          ),
          SizedBox(height: 12.h),
          DetailSentraField(
            icon: Icons.school_outlined,
            label: 'Rombel',
            value: entity.classGroup,
          ),
          SizedBox(height: 12.h),
          DetailSentraField(
            icon: Icons.person_outline,
            label: 'Nama Guru',
            value: entity.teacherName,
          ),
        ],
      ),
    );
  }

  scoreChip(BuildContext context, int score) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: context.brand.green,
        borderRadius: BorderRadius.circular(18.r),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            score.toString(),
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Nilai',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  sectionCard(BuildContext context,
      {required String title, required String body}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: context.brand.green,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            body,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textMain,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
