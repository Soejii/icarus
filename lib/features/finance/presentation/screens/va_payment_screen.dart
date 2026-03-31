import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/va_bank_type.dart';
import 'package:icarus/features/finance/presentation/widgets/payment_instruction_card.dart';
import 'package:icarus/features/finance/presentation/widgets/va_info_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class VaPaymentScreen extends HookConsumerWidget {
  const VaPaymentScreen({super.key, required this.bankType});

  final VaBankType bankType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Bayar Biaya Pendidikan',
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
      body: ListView(
        children: [
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 32.h,
                  width: 98.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      bankType.label.split(' ').map((w) => w[0]).join(),
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: context.brand.primary,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timelapse_outlined,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '23:59:59',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 28.h),
          const VaInfoCard(
            label: 'No. Virtual Account',
            value: '8800012345678901',
          ),
          SizedBox(height: 14.h),
          VaInfoCard(
            label: 'Kode Bank',
            value: bankType.bankCode,
          ),
          SizedBox(height: 14.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catatan',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textSecondary,
                  ),
                ),
                SizedBox(height: 7.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 8,
                        color: Color.fromRGBO(0, 154, 222, 0.15),
                      ),
                    ],
                  ),
                  child: Text(
                    'Tambahkan ${bankType.adminFee} untuk biaya admin',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 27.h),
          Container(
            height: 2,
            width: double.infinity,
            color: const Color.fromRGBO(0, 0, 0, 0.1),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Cara Pembayaran Virtual Account ${bankType.label}',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.brand.textMain,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          ...bankType.instructions.map(
            (instruction) => PaymentInstructionCard(
              title: instruction['title']!,
              description: instruction['description']!,
            ),
          ),
          SizedBox(height: 150.h),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => context.pushNamed(RouteName.pendingConfirmation),
            child: Container(
              height: 56.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
              ),
              child: Center(
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
          SafeArea(
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Center(
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.textSecondary,
                      decoration: TextDecoration.underline,
                      decorationColor: context.brand.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
