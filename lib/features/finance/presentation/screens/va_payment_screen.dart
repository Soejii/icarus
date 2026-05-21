import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/domain/types/va_bank_type.dart';
import 'package:icarus/features/finance/presentation/providers/bank_transfer_info_controller.dart';
import 'package:icarus/features/finance/presentation/providers/payment_action_controller.dart';
import 'package:icarus/features/finance/presentation/providers/payment_flow_notifier.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_instruction_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/utils/currency_helper.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class VaPaymentScreen extends ConsumerStatefulWidget {
  const VaPaymentScreen({super.key, required this.bankType});

  final VaBankType bankType;

  @override
  ConsumerState<VaPaymentScreen> createState() => _VaPaymentScreenState();
}

class _VaPaymentScreenState extends ConsumerState<VaPaymentScreen> {
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => createVa());
  }

  Future<void> createVa() async {
    final bill = ref.read(paymentFlowNotifierProvider).selectedBill;
    if (bill == null) {
      setState(() {
        _loading = false;
        _error = 'Tagihan tidak ditemukan';
      });
      return;
    }

    final child = ref.read(selectedChildProvider);
    if (child == null) {
      setState(() {
        _loading = false;
        _error = 'Data siswa tidak ditemukan';
      });
      return;
    }

    try {
      final data = await ref.read(paymentActionControllerProvider.notifier).createPayment(
        widget.bankType.slug,
        {
          'student_id': child.id,
          'bill_trx_id': bill.id,
          'payment_type': 'bill',
          'amount': ref.read(paymentFlowNotifierProvider.notifier).effectiveAmount,
        },
      );
      final vaNumber = data['virtual_account'] as String?;
      if (vaNumber != null) {
        ref.read(paymentFlowNotifierProvider.notifier).setVaNumber(vaNumber);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(paymentFlowNotifierProvider);
    final bill = flow.selectedBill;
    final bankInfo = ref.watch(bankTransferInfoControllerProvider).valueOrNull;
    final adminFee = switch (bill?.category) {
      BillCategoryType.spp => bankInfo?.adminFeeSpp ?? 0,
      BillCategoryType.dpp => bankInfo?.adminFeeDpp ?? 0,
      BillCategoryType.lainnya => bankInfo?.adminFeeLainnya ?? 0,
      null => 0,
    };
    final totalAmount = (flow.nominalAmount ?? bill?.billAmount ?? 0) + adminFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBarWidget(
        title: 'Bayar Tagihan',
        leadingIcon: true,
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            decoration: BoxDecoration(
              gradient: context.brand.mainGradient,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.bankType.label,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timelapse_outlined,
                          color: Colors.amber[200],
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '23:59:59',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.amber[200],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'No. Virtual Account',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 6.h),
                vaNumberText(context, flow.vaNumber),
                SizedBox(height: 14.h),
                GestureDetector(
                  onTap: flow.vaNumber == null
                      ? null
                      : () async {
                          await Clipboard.setData(
                            ClipboardData(text: flow.vaNumber!),
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('No. VA berhasil disalin'),
                              duration: const Duration(seconds: 2),
                              backgroundColor: context.brand.primary,
                            ),
                          );
                        },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.copy_outlined,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Salin Nomor VA',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          sectionCard(
            context,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Pembayaran',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 14.h),
                detailRow(context, label: 'Kode Bank', value: widget.bankType.bankCode),
                SizedBox(height: 10.h),
                detailRow(context, label: 'Biaya Admin', value: formatRupiah(adminFee)),
                SizedBox(height: 10.h),
                detailRow(context, label: 'Total Tagihan', value: formatRupiah(totalAmount)),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Cara Pembayaran',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: context.brand.textMain,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          ...widget.bankType.instructions.map(
            (instruction) => PaymentInstructionCard(
              title: instruction['title']!,
              description: instruction['description']!,
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: context.brand.invertedShadow,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: context.brand.mainGradient,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ElevatedButton(
                    onPressed: () => context.pushNamed(RouteName.pendingConfirmation),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Saya Sudah Bayar',
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
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget vaNumberText(BuildContext context, String? vaNumber) {
    if (_loading) {
      return const CircularProgressIndicator(color: Colors.white);
    }
    if (_error != null) {
      return Text(
        _error!,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      );
    }
    return Text(
      vaNumber ?? '-',
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
    );
  }

  sectionCard(
    BuildContext context, {
    required EdgeInsetsGeometry padding,
    required Widget child,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: context.brand.shadow,
        ),
        child: child,
      ),
    );
  }

  detailRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textSecondary,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
        ),
      ],
    );
  }
}

extension on VaBankType {
  String get slug => switch (this) {
        VaBankType.bni => 'va-bni',
        VaBankType.bmi => 'va-bmi',
        VaBankType.bca => 'va-bca',
        VaBankType.bsi => 'va-bsi',
      };
}
