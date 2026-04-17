import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/constant/app_colors.dart';
import 'package:icarus/features/edit_child_info/presentation/providers/edit_child_info_providers.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/edit_child_info_tab_bar_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_personal_data_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_address_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_additional_info_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_document_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_school_program_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_bank_info_form_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class EditChildInfoScreen extends HookConsumerWidget {
  const EditChildInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: 6,
      initialIndex: ref.watch(editChildInfoTabIndexProvider),
    );

    ref.listen(editChildInfoTabIndexProvider, (_, next) {
      tabController.index = next;
    });

    useEffect(() {
      void onChange() {
        if (!tabController.indexIsChanging) {
          ref
              .read(editChildInfoTabIndexProvider.notifier)
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
          title: 'Informasi Akun Anak',
          leadingIcon: true,
        ),
        body: Column(
          children: [
            EditChildInfoTabBarWidget(tabController: tabController),
            Expanded(
              child: ColoredBox(
                color: Colors.grey.shade50,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    ChildPersonalDataFormWidget(),
                    ChildAddressFormWidget(),
                    ChildAdditionalInfoFormWidget(),
                    ChildDocumentFormWidget(),
                    ChildSchoolProgramFormWidget(),
                    ChildBankInfoFormWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Perubahan berhasil disimpan',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14.sp,
                        ),
                      ),
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
                      'Submit',
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
