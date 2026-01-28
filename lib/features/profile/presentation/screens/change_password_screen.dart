import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/profile/presentation/providers/change_password_controller.dart';
import 'package:icarus/features/profile/presentation/widgets/change_password_form_field.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ChangePasswordScreen extends HookConsumerWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final showPassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen(changePasswordControllerProvider, (previous, next) {
      next.when(
        loading: () {},
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengubah kata sandi: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        data: (message) {
          if (message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: context.brand.green,
              ),
            );
            currentPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            Navigator.pop(context);
          }
        },
      );
    });

    final changePasswordState = ref.watch(changePasswordControllerProvider);

    void handleSubmit() {
      if (formKey.currentState!.validate()) {
        ref.read(changePasswordControllerProvider.notifier).changePassword(
              currentPassword: currentPasswordController.text,
              newPassword: newPasswordController.text,
              confirmPassword: confirmPasswordController.text,
            );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Ubah Kata Sandi',
        leadingIcon: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          children: [
            ChangePasswordFormField(
              controller: currentPasswordController,
              label: 'Kata Sandi Lama',
              hintText: '**********',
              obscureText: !showPassword.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kata sandi lama tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            ChangePasswordFormField(
              controller: newPasswordController,
              label: 'Kata Sandi Baru',
              hintText: '**********',
              obscureText: !showPassword.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kata sandi baru tidak boleh kosong';
                }
                if (value.length < 8) {
                  return 'Kata sandi baru minimal 8 karakter';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            ChangePasswordFormField(
              controller: confirmPasswordController,
              label: 'Konfirmasi Kata Sandi',
              hintText: '**********',
              obscureText: !showPassword.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Konfirmasi kata sandi tidak boleh kosong';
                }
                if (value != newPasswordController.text) {
                  return 'Konfirmasi kata sandi tidak sama';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Checkbox(
                  value: showPassword.value,
                  onChanged: (value) {
                    showPassword.value = value ?? false;
                  },
                  activeColor: context.brand.primary,
                ),
                Text(
                  'Tampilkan kata sandi',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: changePasswordState.isLoading ? null : handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.brand.primary,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: changePasswordState.isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Ubah Kata Sandi',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
