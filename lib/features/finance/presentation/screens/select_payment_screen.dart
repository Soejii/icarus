import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/va_bank_type.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_action_button.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_method_radio_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class _PaymentMethod {
  const _PaymentMethod({
    required this.slug,
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  final String slug;
  final IconData icon;
  final String label;
  final String subtitle;
}

const _methods = [
  _PaymentMethod(
    slug: 'transfer-bank',
    icon: Icons.account_balance_outlined,
    label: 'Transfer Bank',
    subtitle: 'Transfer manual ke rekening sekolah',
  ),
  _PaymentMethod(
    slug: 'va-bni',
    icon: Icons.credit_card_outlined,
    label: 'Virtual Account BNI',
    subtitle: 'VA Bank Negara Indonesia',
  ),
  _PaymentMethod(
    slug: 'va-bmi',
    icon: Icons.credit_card_outlined,
    label: 'Virtual Account BMI',
    subtitle: 'VA Bank Muamalat Indonesia',
  ),
  _PaymentMethod(
    slug: 'winpay',
    icon: Icons.language_outlined,
    label: 'Winpay',
    subtitle: 'Pembayaran via gateway eksternal',
  ),
  _PaymentMethod(
    slug: 'emoney',
    icon: Icons.account_balance_wallet_outlined,
    label: 'Saldo E-Money',
    subtitle: 'Saldo: Rp 150.000',
  ),
];

class SelectPaymentScreen extends HookConsumerWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSlug = useState<String?>(_methods.first.slug);

    void onLanjutkan() {
      switch (selectedSlug.value) {
        case 'transfer-bank':
          context.pushNamed(RouteName.bankTransferPayment);
        case 'va-bni':
          context.pushNamed(RouteName.vaPayment, extra: VaBankType.bni);
        case 'va-bmi':
          context.pushNamed(RouteName.vaPayment, extra: VaBankType.bmi);
        case 'winpay':
          context.pushNamed(RouteName.paymentGateway);
        case 'emoney':
          context.pushNamed(RouteName.pendingConfirmation);
      }
    }

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
            ..._methods.map(
              (method) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: PaymentMethodRadioCard(
                  icon: method.icon,
                  label: method.label,
                  subtitle: method.subtitle,
                  isSelected: selectedSlug.value == method.slug,
                  onTap: () => selectedSlug.value = method.slug,
                ),
              ),
            ),
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
            onPressed: onLanjutkan,
          ),
        ),
      ),
    );
  }
}
