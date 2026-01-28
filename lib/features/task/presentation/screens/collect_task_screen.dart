import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/task/presentation/providers/submit_task_controller.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';

class CollectTaskScreen extends HookConsumerWidget {
  const CollectTaskScreen({super.key, required this.idTask});
  final int idTask;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(submitTaskControllerProvider(idTask));
    final textController = useTextEditingController();
    final file = useState<File?>(null);

    Future<void> pickFile() async {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        file.value = File(result.files.single.path!);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Kerjakan Tugas',
        leadingIcon: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Catatan',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: context.brand.inactive,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: textController,
                minLines: 2,
                maxLines: 15,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textMain,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tulis Catatan Kamu Disini!',
                  hintStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textMain,
                    fontStyle: FontStyle.italic,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
              onTap: () => pickFile(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(210, 239, 255, 1),
                          Color.fromRGBO(255, 255, 255, 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Image.asset(AssetsHelper.imgUpload),
                  ),
                  SizedBox(width: 14.w),
                  Text(
                    file.value != null
                        ? file.value!.path.split('/').last
                        : 'Upload File',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
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
            onTap: () async {
              if (file.value != null) {
                final res = await ref
                    .read(submitTaskControllerProvider(idTask).notifier)
                    .submitTask(
                      file.value!,
                      textController.text,
                    );
                res.fold(
                  (f) => throw f,
                  (_) => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => successDialog(context),
                  ),
                );
              }
            },
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: context.brand.primary,
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
          ),
        ),
      ),
    );
  }

  successDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: 350.h,
        width: 258.w,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 295.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 46.h),
                    Text(
                      'Berhasil!',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: context.brand.secondary,
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Text(
                      'Tugas kamu sudah berhasil dikirim. Tunggu Review dari pengajar untuk melihat nilai.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: context.brand.textSecondary,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () => context.goNamed(RouteName.activity),
                      child: Container(
                        width: 146.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: context.brand.primary,
                          boxShadow: context.brand.shadow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Kembali',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 142.w,
                height: 142.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.brand.primary,
                    width: 12,
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: SizedBox(
                    height: 110.w,
                    width: 110.w,
                    child: Image.asset(
                      AssetsHelper.imgSuccess,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
