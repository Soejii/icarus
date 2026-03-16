import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_action_button.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_method_radio_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class SelectPaymentScreen extends HookConsumerWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);

    final methods = [
      {'icon': Icons.account_balance, 'label': 'Transfer Bank'},
      {'icon': Icons.account_balance_wallet, 'label': 'E-Wallet'},
      {'icon': Icons.store, 'label': 'Minimarket'},
      {'icon': Icons.credit_card, 'label': 'Kartu Kredit/Debit'},
    ];

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Pilih Pembayaran',
        leadingIcon: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metode Pembayaran',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.brand.textMain,
              ),
            ),
            SizedBox(height: 12.h),
            ...methods.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: PaymentMethodRadioCard(
                  icon: entry.value['icon'] as IconData,
                  label: entry.value['label'] as String,
                  isSelected: selectedIndex.value == entry.key,
                  onTap: () => selectedIndex.value = entry.key,
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: context.brand.invertedShadow,
        ),
        child: SafeArea(
          child: PaymentActionButton(
            label: 'Lanjutkan',
            onPressed: () => context.pushNamed(RouteName.paymentGateway),
          ),
        ),
      ),
    );
  }
}
