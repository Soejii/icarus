import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/task/presentation/providers/detail_task_controller.dart';
import 'package:gaia/features/task/presentation/widgets/detail_task_header_skeleton_widget.dart';
import 'package:gaia/features/task/presentation/widgets/detail_task_header_widget.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailTaskScreen extends ConsumerWidget {
  const DetailTaskScreen({super.key, required this.idTask});
  final int idTask;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asnycTask = ref.watch(detailTaskControllerProvider(idTask));

    bool hasSurpassedDateFromString(String dateString) {
      final targetDate = DateTime.parse(dateString);
      return DateTime.now().isAfter(targetDate);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Detail Tugas',
        leadingIcon: true,
      ),
      body: ListView(
        children: [
          asnycTask.when(
            data: (data) => DetailTaskHeaderWidget(
              entity: data,
            ),
            error: (error, stackTrace) => Text('Terjadi Kesalahan, $error'),
            loading: () => const DetailTaskHeaderSkeletonWidget(),
          ),
          SizedBox(height: 7.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'INSTRUKSI',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 7.h),
          asnycTask.when(
            data: (data) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: 72.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(82, 103, 137, 1),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Html(
                    data: data.instruction ?? '',
                    style: {
                      "body": Style(
                        color: context.brand.textMain,
                        fontFamily: "Open Sans",
                        fontSize: FontSize(14.sp),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        lineHeight: LineHeight.normal,
                      ),
                      "h1": Style(
                          fontSize: FontSize(22.sp),
                          fontWeight: FontWeight.bold),
                      "h2": Style(
                          fontSize: FontSize(20.sp),
                          fontWeight: FontWeight.bold),
                      "h3": Style(
                          fontSize: FontSize(18.sp),
                          fontWeight: FontWeight.w600),
                      "p": Style(margin: Margins.zero),
                      "ul": Style(
                          margin: Margins.zero, padding: HtmlPaddings.zero),
                      "li": Style(margin: Margins.zero),
                      "strong": Style(fontWeight: FontWeight.w600),
                      "em": Style(fontStyle: FontStyle.italic),
                    },
                  ),
                ),
              ),
            ),
            error: (error, stackTrace) => Text('Terjadi Kesalahan, $error'),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80.h,
        decoration:  BoxDecoration(
          color: Colors.white,
          boxShadow: context.brand.invertedShadow,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: GestureDetector(
            onTap: () {
              context.pushNamed(
                RouteName.collectTask,
                pathParameters: {
                  'id': idTask.toString(),
                },
              );
            },
            child: asnycTask.when(
              data: (data) => Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  color: hasSurpassedDateFromString(data.finishAt ?? '')
                      ? context.brand.inactive
                      : context.brand.primary,
                  boxShadow: context.brand.shadow,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Kerjakan',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              error: (error, stackTrace) => Text('Terjadi Kesalahan, $error'),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
