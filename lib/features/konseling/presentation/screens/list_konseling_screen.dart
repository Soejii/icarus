import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/features/konseling/presentation/providers/konseling_controller.dart';
import 'package:icarus/features/konseling/presentation/widgets/konseling_list_content.dart';
import 'package:icarus/features/konseling/presentation/widgets/konseling_tab_bar_widget.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ListKonselingScreen extends HookConsumerWidget {
  const ListKonselingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: konselingTypes.length,
      initialIndex: ref.watch(konselingTabIndexProvider),
    );

    ref.listen(
      konselingTabIndexProvider,
      (previous, next) {
        tabController.index = next;
      },
    );

    useEffect(
      () {
        void onChange() {
          if (!tabController.indexIsChanging) {
            ref
                .read(konselingTabIndexProvider.notifier)
                .set(tabController.index);
          }
        }

        tabController.addListener(onChange);
        return () => tabController.removeListener(onChange);
      },
      [tabController],
    );

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Konseling',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          KonselingTabBarWidget(tabController: tabController),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                KonselingListContent(type: konselingTypes[0]),
                KonselingListContent(type: konselingTypes[1]),
                KonselingListContent(type: konselingTypes[2]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
