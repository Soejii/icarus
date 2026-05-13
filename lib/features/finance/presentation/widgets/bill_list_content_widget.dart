import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/features/finance/presentation/providers/school_bills_paid_controller.dart';
import 'package:icarus/features/finance/presentation/providers/school_bills_controller.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_history_group_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_item_card.dart';
import 'package:icarus/features/finance/presentation/widgets/no_bill_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:intl/intl.dart';

class BillListContentWidget extends HookConsumerWidget {
  const BillListContentWidget({super.key, required this.category});

  final BillCategoryType category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final tabIndex = useState(0);
    final unpaidBills = ref.watch(schoolBillsControllerProvider(category));
    final paidBills = ref.watch(schoolBillsPaidControllerProvider(category));

    useEffect(() {
      void onChange() {
        if (!tabController.indexIsChanging) {
          tabIndex.value = tabController.index;
        }
      }

      tabController.addListener(onChange);
      return () => tabController.removeListener(onChange);
    }, [tabController]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            child: Text(
              'Tagihan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: tabIndex.value == 0
                    ? context.brand.primary
                    : context.brand.inactive,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Riwayat Tagihan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: tabIndex.value == 1
                    ? context.brand.primary
                    : context.brand.inactive,
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          unpaidBills.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Text(
                error.toString(),
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                ),
              ),
            ),
            data: (bills) => bills.isEmpty
                ? const NoBillWidget()
                : ListView.builder(
                    itemCount: bills.length,
                    itemBuilder: (context, index) {
                      final tx = bills[index];
                      return BillItemCard(
                        nominal: formatRupiah(tx.billAmount),
                        jenisPembayaran: tx.billName,
                        date: tx.endDate != null
                            ? DateFormat('d MMM yyyy', 'id_ID').format(tx.endDate!)
                            : '-',
                        status: tx.status,
                        onPressed: () {
                          ref.read(paymentFlowNotifierProvider.notifier).selectBill(tx);
                          switch (tx.status) {
                            case BillStatusType.unpaid:
                            case BillStatusType.installment:
                              context.pushNamed(RouteName.detailTagihan);
                            case BillStatusType.paid:
                            case BillStatusType.pending:
                            case BillStatusType.confirmed:
                              context.pushNamed(RouteName.detailPembayaran);
                          }
                        },
                      );
                    },
                  ),
          ),
          paidBills.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Text(
                error.toString(),
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                ),
              ),
            ),
            data: (bills) => historyList(context, ref, bills),
          ),
        ],
      ),
    );
  }

  Widget historyList(
    BuildContext context,
    WidgetRef ref,
    List<BillTransactionEntity> bills,
  ) {
    if (bills.isEmpty) return const NoBillWidget();

    final grouped = <String, List<Map<String, dynamic>>>{};
    for (final tx in bills) {
      final year = tx.payDate?.year.toString() ?? 'Unknown';
      grouped.putIfAbsent(year, () => []).add({
            'nominal': formatRupiah(tx.paidAmount > 0 ? tx.paidAmount : tx.billAmount),
            'jenisPembayaran': tx.billName,
            'date': tx.payDate != null
                ? DateFormat('d MMM yyyy', 'id_ID').format(tx.payDate!)
                : '-',
            'status': tx.status,
            'entity': tx,
          });
    }

    final groups = grouped.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return BillHistoryGroupWidget(
          year: group.key,
          bills: group.value,
          onBillTap: (bill) {
            final tx = bill['entity'] as BillTransactionEntity;
            ref.read(paymentFlowNotifierProvider.notifier).selectBill(tx);
            context.pushNamed(RouteName.detailPembayaran);
          },
        );
      },
    );
  }
}
