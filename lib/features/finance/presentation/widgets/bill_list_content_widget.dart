import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_history_group_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_item_card.dart';
import 'package:icarus/features/finance/presentation/widgets/no_bill_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class BillListContentWidget extends HookConsumerWidget {
  const BillListContentWidget({super.key, required this.category});

  final BillCategoryType category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final tabIndex = useState(0);

    useEffect(() {
      void onChange() {
        if (!tabController.indexIsChanging) {
          tabIndex.value = tabController.index;
        }
      }

      tabController.addListener(onChange);
      return () => tabController.removeListener(onChange);
    }, [tabController]);

    final unpaidBills = _mockUnpaidBills(category);
    final paidGroups = _mockPaidGroups(category);

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
          // Tagihan (Unpaid)
          unpaidBills.isNotEmpty
              ? ListView.builder(
                  itemCount: unpaidBills.length,
                  itemBuilder: (context, index) {
                    final bill = unpaidBills[index];
                    final status = bill['status'] as BillStatusType;
                    return BillItemCard(
                      nominal: bill['nominal'] as String,
                      jenisPembayaran: bill['jenisPembayaran'] as String,
                      date: bill['date'] as String,
                      status: status,
                      onPressed: () {
                        switch (status) {
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
                )
              : const NoBillWidget(),
          // Riwayat Tagihan (Paid history grouped by year)
          paidGroups.isNotEmpty
              ? ListView.builder(
                  itemCount: paidGroups.length,
                  itemBuilder: (context, index) {
                    final group = paidGroups[index];
                    return BillHistoryGroupWidget(
                      year: group['year'] as String,
                      bills:
                          group['bills'] as List<Map<String, dynamic>>,
                      onBillTap: (_) =>
                          context.pushNamed(RouteName.detailPembayaran),
                    );
                  },
                )
              : const NoBillWidget(),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _mockUnpaidBills(BillCategoryType category) {
    switch (category) {
      case BillCategoryType.spp:
        return [
          {
            'nominal': 'Rp 500.000',
            'jenisPembayaran': 'SPP Maret 2026',
            'date': '15 Maret 2026',
            'status': BillStatusType.unpaid,
          },
          {
            'nominal': 'Rp 500.000',
            'jenisPembayaran': 'SPP Februari 2026',
            'date': '15 Februari 2026',
            'status': BillStatusType.installment,
          },
          {
            'nominal': 'Rp 500.000',
            'jenisPembayaran': 'SPP Januari 2026',
            'date': '15 Januari 2026',
            'status': BillStatusType.pending,
          },
        ];
      case BillCategoryType.dpp:
        return [
          {
            'nominal': 'Rp 1.200.000',
            'jenisPembayaran': 'DPP Semester Genap',
            'date': '10 Januari 2026',
            'status': BillStatusType.unpaid,
          },
        ];
      case BillCategoryType.lainnya:
        return [
          {
            'nominal': 'Rp 300.000',
            'jenisPembayaran': 'Uang Seragam',
            'date': '20 Februari 2026',
            'status': BillStatusType.unpaid,
          },
        ];
    }
  }

  List<Map<String, dynamic>> _mockPaidGroups(BillCategoryType category) {
    switch (category) {
      case BillCategoryType.spp:
        return [
          {
            'year': 'Kelas 6 - 2025/2026',
            'bills': <Map<String, dynamic>>[
              {
                'nominal': 'Rp 500.000',
                'jenisPembayaran': 'SPP Desember 2025',
                'date': '15 Desember 2025',
                'status': BillStatusType.confirmed,
              },
              {
                'nominal': 'Rp 500.000',
                'jenisPembayaran': 'SPP November 2025',
                'date': '15 November 2025',
                'status': BillStatusType.confirmed,
              },
            ],
          },
          {
            'year': 'Kelas 5 - 2024/2025',
            'bills': <Map<String, dynamic>>[
              {
                'nominal': 'Lunas',
                'jenisPembayaran': 'SPP Juni 2025',
                'date': '15 Juni 2025',
                'status': BillStatusType.confirmed,
              },
            ],
          },
        ];
      case BillCategoryType.dpp:
        return [
          {
            'year': 'Kelas 5 - 2024/2025',
            'bills': <Map<String, dynamic>>[
              {
                'nominal': 'Rp 1.200.000',
                'jenisPembayaran': 'DPP Semester Ganjil',
                'date': '10 Juli 2024',
                'status': BillStatusType.confirmed,
              },
            ],
          },
        ];
      case BillCategoryType.lainnya:
        return [
          {
            'year': 'Kelas 6 - 2025/2026',
            'bills': <Map<String, dynamic>>[
              {
                'nominal': 'Rp 150.000',
                'jenisPembayaran': 'Uang Kegiatan',
                'date': '5 Oktober 2025',
                'status': BillStatusType.confirmed,
              },
            ],
          },
        ];
    }
  }
}
