import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/features/balances/presentation/providers/balance_providers.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_tab_bar_widget.dart';
import 'package:gaia/features/balances/presentation/widgets/balance_content_widget.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BalanceScreen extends HookConsumerWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
        initialLength: balanceTypes.length,
        initialIndex: ref.watch(balanceTabIndexProvider));

    useEffect(
      () {
        void onChange() {
          if (!tabController.indexIsChanging) {
            ref.read(balanceTabIndexProvider.notifier).set(tabController.index);
          }
        }

        tabController.addListener(() => onChange());

        return () => tabController.removeListener(onChange);
      },
      [tabController],
    );

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Keuangan',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          BalanceTabBarWidget(tabBarController: tabController),
          SizedBox(height: 20.h),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                BalanceContentScreen(type: BalanceType.savings),
                BalanceContentScreen(type: BalanceType.emoney),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

