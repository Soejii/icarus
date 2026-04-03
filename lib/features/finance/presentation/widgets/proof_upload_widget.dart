import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:image_picker/image_picker.dart';

class ProofUploadWidget extends HookWidget {
  const ProofUploadWidget({
    super.key,
    this.onImageSelected,
  });

  final ValueChanged<XFile?>? onImageSelected;

  @override
  Widget build(BuildContext context) {
    final image = useState<XFile?>(null);

    Future<void> pickImage(BuildContext sheetContext, ImageSource source) async {
      Navigator.pop(sheetContext);
      final picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        image.value = picked;
        onImageSelected?.call(picked);
      }
    }

    void showPickerSheet() {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: context.brand.primary,
                ),
                title: Text(
                  'Ambil dari Kamera',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
                onTap: () => pickImage(sheetContext, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library_outlined,
                  color: context.brand.primary,
                ),
                title: Text(
                  'Pilih dari Galeri',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
                onTap: () => pickImage(sheetContext, ImageSource.gallery),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      );
    }

    return Center(
      child: GestureDetector(
        onTap: showPickerSheet,
        child: Container(
          height: 261.h,
          width: 336.w,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: context.brand.primary,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: image.value != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Image.file(
                        File(image.value!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: showPickerSheet,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            'Ganti',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 40.w,
                      color: context.brand.primary,
                    ),
                    SizedBox(height: 19.h),
                    Text(
                      'Upload Bukti Pembayaran',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.brand.primary,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
