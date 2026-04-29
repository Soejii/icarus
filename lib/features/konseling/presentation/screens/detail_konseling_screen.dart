import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/features/konseling/presentation/providers/konseling_controller.dart';
import 'package:icarus/features/konseling/presentation/widgets/detail_konseling_field.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class DetailKonselingScreen extends ConsumerWidget {
  const DetailKonselingScreen({
    super.key,
    required this.id,
    required this.type,
  });

  final int id;
  final KonselingType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEntity =
        ref.watch(detailKonselingControllerProvider(type, id));

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Detail Konseling',
        leadingIcon: true,
      ),
      body: asyncEntity.when(
        data: (entity) => detailBody(context, entity, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () =>
              ref.invalidate(detailKonselingControllerProvider(type, id)),
        ),
      ),
    );
  }

  Widget detailBody(
      BuildContext context, KonselingEntity entity, WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      children: [
        headerCard(context, entity),
        SizedBox(height: 12.h),
        if (entity.deskripsi != null)
          sectionCard(
            context,
            title: 'Deskripsi Masalah Konseling',
            body: entity.deskripsi!,
          ),
        if (entity.deskripsi != null) SizedBox(height: 12.h),
        if (entity.evaluasi != null)
          sectionCard(
            context,
            title: 'Evaluasi',
            body: entity.evaluasi!,
          ),
        if (entity.lampiranUrl != null) ...[
          SizedBox(height: 20.h),
          attachmentButton(context),
        ],
        SizedBox(height: 24.h),
      ],
    );
  }

  headerCard(BuildContext context, KonselingEntity entity) {
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
          Text(
            'Topik Konseling',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            entity.topik,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: context.brand.textMain,
              height: 1.3,
            ),
          ),
          SizedBox(height: 14.h),
          Container(height: 1.h, color: context.brand.inactive),
          SizedBox(height: 14.h),
          DetailKonselingField(
            icon: Icons.event_outlined,
            label: 'Tanggal',
            value: entity.tanggal,
          ),
          SizedBox(height: 12.h),
          DetailKonselingField(
            icon: Icons.access_time_outlined,
            label: 'Durasi Konseling',
            value: '${entity.durasiMenit} Menit',
          ),
          if (entity.namaGuru != null) ...[
            SizedBox(height: 12.h),
            DetailKonselingField(
              icon: Icons.person_outline,
              label: 'Nama Guru',
              value: entity.namaGuru!,
            ),
          ],
          if (entity.pendekatan != null) ...[
            SizedBox(height: 12.h),
            DetailKonselingField(
              icon: Icons.psychology_outlined,
              label: 'Pendekatan',
              value: entity.pendekatan!,
            ),
          ],
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

  attachmentButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.brand.green, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.attach_file_outlined,
              size: 18.sp,
              color: context.brand.green,
            ),
            SizedBox(width: 8.w),
            Text(
              'Lihat Lampiran',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: context.brand.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
