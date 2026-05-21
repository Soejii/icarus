import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/entities/emoney_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/payment_method_entity.dart';
import 'package:icarus/features/finance/domain/types/va_bank_type.dart';
import 'package:icarus/features/finance/presentation/providers/emoney_detail_controller.dart';
import 'package:icarus/features/finance/presentation/providers/payment_action_controller.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/features/finance/presentation/providers/payment_methods_controller.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_action_button.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_method_radio_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentMethodOption {
  const PaymentMethodOption({
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

class SelectPaymentScreen extends HookConsumerWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSlug = useState<String?>(null);
    final submitting = useState(false);
    final methodsAsync = ref.watch(paymentMethodsControllerProvider);
    final emoneyDetail = ref.watch(emoneyDetailControllerProvider).valueOrNull;
    final flow = ref.watch(paymentFlowNotifierProvider);
    final isMultiBill = flow.selectedBills.isNotEmpty;

    const multiBillSlugs = {'emoney', 'transfer-bank', 'winpay'};

    void onLanjutkan() async {
      final slug = selectedSlug.value;
      if (slug == null || submitting.value) return;
      ref.read(paymentFlowNotifierProvider.notifier).setPaymentMethod(slug);

      if (isMultiBill) {
        final bills = flow.selectedBills
            .map((b) => <String, dynamic>{
                  'bill_trx_id': b.id,
                  'notes': flow.notes ?? '',
                  'amount': b.billAmount,
                })
            .toList();
        submitting.value = true;
        try {
          final data = await ref
              .read(paymentActionControllerProvider.notifier)
              .payMultiple(slug, bills);
          if (!context.mounted) return;
          if (slug == 'winpay') {
            final redirectUrl = data['redirect_url'] as String?;
            if (redirectUrl != null) {
              ref
                  .read(paymentFlowNotifierProvider.notifier)
                  .setRedirectUrl(redirectUrl);
              await launchUrl(
                Uri.parse(redirectUrl),
                mode: LaunchMode.externalApplication,
              );
            }
            if (!context.mounted) return;
            context.pushNamed(RouteName.pendingConfirmation);
          } else if (slug == 'transfer-bank') {
            context.pushNamed(RouteName.bankTransferPayment);
          } else {
            context.pushNamed(RouteName.pendingConfirmation);
          }
        } catch (e) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        } finally {
          if (context.mounted) submitting.value = false;
        }
        return;
      }

      switch (slug) {
        case 'transfer-bank':
          context.pushNamed(RouteName.bankTransferPayment);
        case 'va-bni':
          context.pushNamed(RouteName.vaPayment, extra: VaBankType.bni);
        case 'va-bmi':
          context.pushNamed(RouteName.vaPayment, extra: VaBankType.bmi);
        case 'va-bca':
          context.pushNamed(RouteName.vaPayment, extra: VaBankType.bca);
        case 'va-bsi':
          context.pushNamed(RouteName.vaPayment, extra: VaBankType.bsi);
        case 'winpay':
          context.pushNamed(RouteName.paymentGateway);
        case 'emoney':
          final bill = flow.selectedBill;
          if (bill == null) return;
          submitting.value = true;
          try {
            await ref
                .read(paymentActionControllerProvider.notifier)
                .payWithEmoney(
                  billTrxId: bill.id,
                  amount: ref
                      .read(paymentFlowNotifierProvider.notifier)
                      .effectiveAmount,
                  notes: flow.notes,
                );
            if (!context.mounted) return;
            context.pushNamed(RouteName.transactionSuccess);
          } catch (e) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          } finally {
            if (context.mounted) submitting.value = false;
          }
      }
    }

    final methods = methodsAsync.valueOrNull
        ?.where((m) => !isMultiBill || multiBillSlugs.contains(m.slug))
        .map((method) => paymentMethod(method, emoneyDetail))
        .toList();

    useEffect(() {
      if (selectedSlug.value == null && methods != null && methods.isNotEmpty) {
        selectedSlug.value = methods.first.slug;
      }
      return null;
    }, [methods?.length]);

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
            methodsAsync.when(
              loading: () => const Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Expanded(
                child: Center(
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
              ),
              data: (_) => Expanded(
                child: ListView(
                  children: [
                    ...?methods?.map(
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
            label: submitting.value ? 'Memproses...' : 'Lanjutkan',
            onPressed: (methodsAsync.hasValue && !submitting.value)
                ? onLanjutkan
                : () {},
          ),
        ),
      ),
    );
  }

  PaymentMethodOption paymentMethod(
    PaymentMethodEntity method,
    EmoneyDetailEntity? emoneyDetail,
  ) {
    return switch (method.slug) {
      'transfer-bank' => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.account_balance_outlined,
          label: method.name,
          subtitle: 'Transfer manual ke rekening sekolah',
        ),
      'va-bni' => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.credit_card_outlined,
          label: method.name,
          subtitle: 'VA Bank Negara Indonesia',
        ),
      'va-bmi' => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.credit_card_outlined,
          label: method.name,
          subtitle: 'VA Bank Muamalat Indonesia',
        ),
      'va-bca' => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.credit_card_outlined,
          label: method.name,
          subtitle: 'VA Bank Central Asia',
        ),
      'va-bsi' => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.credit_card_outlined,
          label: method.name,
          subtitle: 'VA Bank Syariah Indonesia',
        ),
      'winpay' => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.language_outlined,
          label: method.name,
          subtitle: 'Pembayaran via gateway eksternal',
        ),
      'emoney' => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.account_balance_wallet_outlined,
          label: method.name,
          subtitle: 'Saldo: ${formatRupiah(emoneyDetail?.saldoEmoney ?? 0)}',
        ),
      _ => PaymentMethodOption(
          slug: method.slug,
          icon: Icons.payment_outlined,
          label: method.name,
          subtitle: method.name,
        ),
    };
  }
}
