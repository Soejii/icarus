import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_checkbox_item.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_type_checkbox_row.dart';
import 'package:icarus/features/finance/presentation/widgets/multi_select_bottom_bar.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class MultiSelectPaymentScreen extends HookConsumerWidget {
  const MultiSelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mockData = _buildMockData();

    // Track checked state: Map<typeIndex, Map<billIndex, bool>>
    final checkedState = useState<Map<int, Map<int, bool>>>({
      for (int i = 0; i < mockData.length; i++)
        i: {
          for (int j = 0; j < (mockData[i]['bills'] as List).length; j++)
            j: false,
        },
    });

    // Track type-level checked state
    final typeChecked = useState<Map<int, bool>>({
      for (int i = 0; i < mockData.length; i++) i: false,
    });

    int calculateTotal() {
      int total = 0;
      for (final typeEntry in checkedState.value.entries) {
        final bills = mockData[typeEntry.key]['bills'] as List<Map<String, dynamic>>;
        for (final billEntry in typeEntry.value.entries) {
          if (billEntry.value) {
            total += bills[billEntry.key]['amount'] as int;
          }
        }
      }
      return total;
    }

    String formatCurrency(int amount) {
      final str = amount.toString();
      final buffer = StringBuffer();
      for (int i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
        buffer.write(str[i]);
      }
      return 'Rp $buffer';
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

      final allChecked = billMap.values.every((v) => v);
      final newTypeChecked = Map<int, bool>.from(typeChecked.value);
      newTypeChecked[typeIndex] = allChecked;
      typeChecked.value = newTypeChecked;
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
      body: ListView.builder(
        itemCount: mockData.length,
        itemBuilder: (context, typeIndex) {
          final type = mockData[typeIndex];
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
                  amount: _formatAmount(bill['amount'] as int),
                  billName: bill['name'] as String,
                  date: bill['date'] as String,
                  isChecked:
                      checkedState.value[typeIndex]?[billIndex] ?? false,
                  onChanged: (value) =>
                      toggleBill(typeIndex, billIndex, value),
                );
              }),
            ],
          );
        },
      ),
      bottomNavigationBar: MultiSelectBottomBar(
        totalAmount: formatCurrency(calculateTotal()),
        onContinue: () => context.pushNamed(RouteName.selectPayment),
      ),
    );
  }

  String _formatAmount(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  List<Map<String, dynamic>> _buildMockData() {
    return [
      {
        'name': 'SPP',
        'bills': <Map<String, dynamic>>[
          {
            'name': 'SPP Maret 2026',
            'amount': 500000,
            'date': '15 Maret 2026',
          },
          {
            'name': 'SPP Februari 2026',
            'amount': 500000,
            'date': '15 Februari 2026',
          },
        ],
      },
      {
        'name': 'DPP',
        'bills': <Map<String, dynamic>>[
          {
            'name': 'DPP Semester Genap',
            'amount': 1200000,
            'date': '10 Januari 2026',
          },
          {
            'name': 'DPP Semester Ganjil',
            'amount': 1200000,
            'date': '10 Juli 2025',
          },
        ],
      },
      {
        'name': 'Lainnya',
        'bills': <Map<String, dynamic>>[
          {
            'name': 'Uang Seragam',
            'amount': 300000,
            'date': '20 Februari 2026',
          },
          {
            'name': 'Uang Kegiatan',
            'amount': 150000,
            'date': '5 Oktober 2025',
          },
          {
            'name': 'Uang Wisuda',
            'amount': 200000,
            'date': '1 Juni 2026',
          },
        ],
      },
    ];
  }
}
