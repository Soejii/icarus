import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/features/edit_child_info/presentation/providers/edit_child_info_providers.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/edit_child_info_tab_bar_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_personal_data_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_address_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_additional_info_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_document_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_school_program_form_widget.dart';
import 'package:icarus/features/edit_child_info/presentation/widgets/child_bank_info_form_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ChildDetailScreen extends HookConsumerWidget {
  final ChildEntity child;

  const ChildDetailScreen({super.key, required this.child});

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(
        title: 'Detail Siswa - ${child.name}',
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
                  ChildPersonalDataFormWidget(readOnly: true),
                  ChildAddressFormWidget(readOnly: true),
                  ChildAdditionalInfoFormWidget(readOnly: true),
                  ChildDocumentFormWidget(readOnly: true),
                  ChildSchoolProgramFormWidget(readOnly: true),
                  ChildBankInfoFormWidget(readOnly: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
