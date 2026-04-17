import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/constant/app_colors.dart';
import 'package:icarus/features/edit_personal_info/presentation/providers/edit_personal_info_providers.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/edit_personal_info_tab_bar_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/parent_data_form_widget.dart';
import 'package:icarus/features/edit_personal_info/presentation/widgets/whatsapp_form_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class EditPersonalInfoScreen extends HookConsumerWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: 4,
      initialIndex: ref.watch(editPersonalInfoTabIndexProvider),
    );

    ref.listen(editPersonalInfoTabIndexProvider, (_, next) {
      tabController.index = next;
    });

    useEffect(() {
      void onChange() {
        if (!tabController.indexIsChanging) {
          ref
              .read(editPersonalInfoTabIndexProvider.notifier)
              .set(tabController.index);
        }
      }

      tabController.addListener(onChange);
      return () => tabController.removeListener(onChange);
    }, [tabController]);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Buang Perubahan?',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
            content: Text(
              'Perubahan yang belum disimpan akan hilang.',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text(
                  'Batal',
                  style: TextStyle(fontFamily: 'OpenSans'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text(
                  'Ya, Buang',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: AppColors.danger,
                  ),
                ),
              ),
            ],
          ),
        );
        if ((confirmed ?? false) && context.mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: const CustomAppBarWidget(
          title: 'Ubah Data Diri',
          leadingIcon: true,
        ),
        body: Column(
          children: [
            EditPersonalInfoTabBarWidget(tabController: tabController),
            Expanded(
              child: ColoredBox(
                color: Colors.grey.shade50,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    WhatsappFormWidget(),
                    ParentDataFormWidget(parentLabel: 'Ayah'),
                    ParentDataFormWidget(parentLabel: 'Ibu'),
                    ParentDataFormWidget(parentLabel: 'Wali'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perubahan berhasil disimpan'),
                    ),
                  );
                },
                child: Container(
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: context.brand.mainGradient,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
