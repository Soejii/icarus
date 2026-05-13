import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/providers/payment_action_controller.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_summary_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/student_info_card.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentGatewayScreen extends ConsumerStatefulWidget {
  const PaymentGatewayScreen({super.key});

  @override
  ConsumerState<PaymentGatewayScreen> createState() =>
      _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends ConsumerState<PaymentGatewayScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(paymentFlowNotifierProvider);
    final bill = flow.selectedBill;

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Bayar Tagihan',
        leadingIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            const StudentInfoCard(),
            SizedBox(height: 16.h),
            const PaymentSummaryWidget(),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFD97706),
                    size: 18,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Anda akan diarahkan ke halaman pembayaran eksternal. Pastikan koneksi internet stabil sebelum melanjutkan.',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
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
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: context.brand.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    'Batalkan',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: context.brand.mainGradient,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ElevatedButton(
                    onPressed: _loading || bill == null
                        ? null
                        : () async {
                            setState(() => _loading = true);
                            try {
                              final data = await ref
                                  .read(paymentActionControllerProvider.notifier)
                                  .createPayment(
                                'winpay',
                                {
                                  'bill_trx_id': bill.id,
                                  'amount': ref
                                      .read(paymentFlowNotifierProvider.notifier)
                                      .effectiveAmount,
                                },
                              );
                              final redirectUrl = data['redirect_url'] as String?;
                              if (redirectUrl == null) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('URL pembayaran tidak tersedia')),
                                );
                                return;
                              }
                              ref
                                  .read(paymentFlowNotifierProvider.notifier)
                                  .setRedirectUrl(redirectUrl);
                              await launchUrl(
                                Uri.parse(redirectUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            } catch (e) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            } finally {
                              if (mounted) {
                                setState(() => _loading = false);
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: _loading
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Lanjutkan ke Pembayaran',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
