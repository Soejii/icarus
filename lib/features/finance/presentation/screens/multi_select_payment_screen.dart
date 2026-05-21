import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/features/finance/presentation/providers/school_bills_controller.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_checkbox_item.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_type_checkbox_row.dart';
import 'package:icarus/features/finance/presentation/widgets/multi_select_bottom_bar.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:intl/intl.dart';

class MultiSelectPaymentScreen extends HookConsumerWidget {
  const MultiSelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sppAsync = ref.watch(schoolBillsControllerProvider(BillCategoryType.spp));
    final dppAsync = ref.watch(schoolBillsControllerProvider(BillCategoryType.dpp));
    final lainnyaAsync = ref.watch(schoolBillsControllerProvider(BillCategoryType.lainnya));

    final isLoading = sppAsync.isLoading || dppAsync.isLoading || lainnyaAsync.isLoading;
    final hasError = sppAsync.hasError || dppAsync.hasError || lainnyaAsync.hasError;
    final data = sppAsync.hasValue && dppAsync.hasValue && lainnyaAsync.hasValue
        ? [
            billGroup(BillCategoryType.spp, sppAsync.valueOrNull ?? []),
            billGroup(BillCategoryType.dpp, dppAsync.valueOrNull ?? []),
            billGroup(BillCategoryType.lainnya, lainnyaAsync.valueOrNull ?? []),
          ]
        : <Map<String, dynamic>>[];

    final checkedState = useState<Map<int, Map<int, bool>>>({
      for (int i = 0; i < data.length; i++)
        i: {
          for (int j = 0; j < (data[i]['bills'] as List).length; j++) j: false,
        },
    });

    final typeChecked = useState<Map<int, bool>>({
      for (int i = 0; i < data.length; i++) i: false,
    });

    useEffect(() {
      checkedState.value = {
        for (int i = 0; i < data.length; i++)
          i: {
            for (int j = 0; j < (data[i]['bills'] as List).length; j++) j: false,
          },
      };
      typeChecked.value = {for (int i = 0; i < data.length; i++) i: false};
      return null;
    }, [data.length]);

    int calculateTotal() {
      int total = 0;
      for (final typeEntry in checkedState.value.entries) {
        final bills = data[typeEntry.key]['bills'] as List<Map<String, dynamic>>;
        for (final billEntry in typeEntry.value.entries) {
          if (billEntry.value) {
            total += bills[billEntry.key]['amount'] as int;
          }
        }
      }
      return total;
    }

    void toggleType(int typeIndex, bool value) {
      final newState = Map<int, Map<int, bool>>.from(checkedState.value);
      final billMap = Map<int, bool>.from(newState[typeIndex]!);
      for (final key in billMap.keys) {
        billMap[key] = value;
      }
      newState[typeIndex] = billMap;
      checkedState.value = newState;

      final newTypeChecked = Map<int, bool>.from(typeChecked.value);
      newTypeChecked[typeIndex] = value;
      typeChecked.value = newTypeChecked;
    }

    void toggleBill(int typeIndex, int billIndex, bool value) {
      final newState = Map<int, Map<int, bool>>.from(checkedState.value);
      final billMap = Map<int, bool>.from(newState[typeIndex]!);
      billMap[billIndex] = value;
      newState[typeIndex] = billMap;
      checkedState.value = newState;

      final allChecked = billMap.values.isNotEmpty && billMap.values.every((v) => v);
      final newTypeChecked = Map<int, bool>.from(typeChecked.value);
      newTypeChecked[typeIndex] = allChecked;
      typeChecked.value = newTypeChecked;
    }

    void onContinue() {
      final checkedEntities = <BillTransactionEntity>[];
      for (final typeEntry in checkedState.value.entries) {
        final bills = data[typeEntry.key]['bills'] as List<Map<String, dynamic>>;
        for (final billEntry in typeEntry.value.entries) {
          if (billEntry.value) {
            checkedEntities.add(bills[billEntry.key]['entity'] as BillTransactionEntity);
          }
        }
      }
      if (checkedEntities.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih setidaknya satu tagihan')),
        );
        return;
      }
      ref.read(paymentFlowNotifierProvider.notifier).setSelectedBills(checkedEntities);
      context.pushNamed(RouteName.selectPayment);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Bayar',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.brand.textMain,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_sharp,
            color: context.brand.textMain,
          ),
        ),
      ),
      body: body(context, isLoading, hasError, data, checkedState, typeChecked, toggleType, toggleBill),
      bottomNavigationBar: MultiSelectBottomBar(
        totalAmount: formatRupiah(calculateTotal()),
        onContinue: onContinue,
      ),
    );
  }

  Widget body(
    BuildContext context,
    bool isLoading,
    bool hasError,
    List<Map<String, dynamic>> data,
    ValueNotifier<Map<int, Map<int, bool>>> checkedState,
    ValueNotifier<Map<int, bool>> typeChecked,
    void Function(int typeIndex, bool value) toggleType,
    void Function(int typeIndex, int billIndex, bool value) toggleBill,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (hasError) {
      return Center(
        child: Text(
          'Gagal memuat tagihan',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textSecondary,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, typeIndex) {
        final type = data[typeIndex];
        final bills = type['bills'] as List<Map<String, dynamic>>;
        return Column(
          children: [
            BillTypeCheckboxRow(
              typeName: type['name'] as String,
              isChecked: typeChecked.value[typeIndex] ?? false,
              onChanged: (value) => toggleType(typeIndex, value),
            ),
            ...List.generate(bills.length, (billIndex) {
              final bill = bills[billIndex];
              return BillCheckboxItem(
                amount: (bill['amount'] as int).toString(),
                billName: bill['name'] as String,
                date: bill['date'] as String,
                isChecked: checkedState.value[typeIndex]?[billIndex] ?? false,
                onChanged: (value) => toggleBill(typeIndex, billIndex, value),
              );
            }),
          ],
        );
      },
    );
  }

  Map<String, dynamic> billGroup(
    BillCategoryType category,
    List<BillTransactionEntity> txs,
  ) {
    return {
      'name': category.label,
      'bills': txs
          .map(
            (tx) => {
              'name': tx.billName,
              'amount': tx.billAmount,
              'date': tx.endDate != null
                  ? DateFormat('d MMM yyyy', 'id_ID').format(tx.endDate!)
                  : '-',
              'entity': tx,
            },
          )
          .toList(),
    };
  }
}
