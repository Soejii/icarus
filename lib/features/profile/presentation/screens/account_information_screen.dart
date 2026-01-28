import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:icarus/features/profile/presentation/providers/profile_controller.dart';
import 'package:icarus/features/profile/presentation/widgets/account_information_content.dart';

class AccountInformationScreen extends ConsumerWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Informasi Akun',
        leadingIcon: true,
      ),
      body: profileAsync.when(
        data: (profile) {
          final accountItems = [
            AccountInfoItem(
              label: 'Nama Lengkap',
              value: profile.name,
            ),
            AccountInfoItem(
              label: 'Username',
              value: profile.username,
            ),
            AccountInfoItem(
              label: 'Email',
              value: profile.email,
            ),
            AccountInfoItem(
              label: 'NIS',
              value: profile.nis,
            ),
            AccountInfoItem(
              label: 'NISN',
              value: profile.nisn,
            ),
            AccountInfoItem(
              label: 'Tempat dan Tanggal Lahir',
              value: '${profile.birthplace}, ${profile.birthdate}',
            ),
            AccountInfoItem(
              label: 'Jenis Kelamin',
              value: profile.gender,
            ),
            AccountInfoItem(
              label: 'Agama',
              value: profile.religion,
            ),
            AccountInfoItem(
              label: 'Alamat Sesuai KTP',
              value: profile.address,
            ),
            AccountInfoItem(
              label: 'Asal Sekolah',
              value: profile.schoolOrigin,
            ),
          ];

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemCount: accountItems.length,
            itemBuilder: (context, index) {
              return AccountInfoField(
                item: accountItems[index],
              );
            },
          );
        },
        loading: () =>  Center(
          child: CircularProgressIndicator(
            color: context.brand.primary,
          ),
        ),
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(profileControllerProvider),
        ),
      ),
    );
  }
}
