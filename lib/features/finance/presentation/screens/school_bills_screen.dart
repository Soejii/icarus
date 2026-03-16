import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_category_pill_widget.dart';
import 'package:icarus/features/finance/presentation/widgets/bill_list_content_widget.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class SchoolBillsScreen extends HookConsumerWidget {
  const SchoolBillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 104),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: AppBar(
                  backgroundColor: Colors.white,
                  scrolledUnderElevation: 0,
                  title: Text(
                    'Pembayaran Sekolah',
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
              ),
              BillCategoryPillWidget(
                selectedIndex: selectedIndex.value,
                onTap: (index) => selectedIndex.value = index,
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex.value,
        children: billCategories
            .map((cat) => BillListContentWidget(category: cat))
            .toList(),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => context.pushNamed(RouteName.pilihMetodeKeuangan),
        child: Container(
          height: 56.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: context.brand.mainGradient,
          ),
          child: Center(
            child: Text(
              'Bayar Tagihan',
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
    );
  }
}
