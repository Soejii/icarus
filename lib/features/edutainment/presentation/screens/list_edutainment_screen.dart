import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/edutainment/domain/type/edutainment_type.dart';
import 'package:icarus/features/edutainment/presentation/providers/edutainment_providers.dart';
import 'package:icarus/features/edutainment/presentation/widgets/edutainment_content_widget.dart';
import 'package:icarus/features/edutainment/presentation/widgets/edutainment_tab_bar_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListEdutainmentScreen extends HookConsumerWidget {
  const ListEdutainmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: edutainmentTypes.length,
      initialIndex: ref.watch(edutainmentTabIndexProvider),
    );

    useEffect(
      () {
        void onChange() {
          if (!tabController.indexIsChanging) {
            ref
                .read(edutainmentTabIndexProvider.notifier)
                .set(tabController.index);
          }
        }

        tabController.addListener(
          () => onChange(),
        );
        return () => tabController.removeListener(onChange);
      },
      [tabController],
    );

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Rubrik Edutainment',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          EdutainmentTabBarWidget(tabController: tabController),
          SizedBox(height: 20.h),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: edutainmentTypes
                  .asMap()
                  .entries
                  .map(
                    (e) => EdutainmentContentWidget(
                      type: e.value,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
