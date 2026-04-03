import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/widgets/menu_card_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class PilihMetodeKeuanganScreen extends HookConsumerWidget {
  const PilihMetodeKeuanganScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Pilih Metode Pembayaran',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 33.h),
          MenuCardWidget(
            icon: Icons.receipt_long,
            name: 'Bayar Tagihan',
            description: 'Pembayaran ke 1 tagihan',
            onTap: () => context.pushNamed(RouteName.schoolBills),
          ),
          SizedBox(height: 16.h),
          MenuCardWidget(
            icon: Icons.receipt,
            name: 'Bayar Banyak Tagihan',
            description: 'Pembayaran ke beberapa tagihan',
            onTap: () => context.pushNamed(RouteName.multiSelectPayment),
          ),
        ],
      ),
    );
  }
}
