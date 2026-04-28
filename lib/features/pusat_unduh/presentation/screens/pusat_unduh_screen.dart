import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/pusat_unduh/presentation/providers/pusat_unduh_controller.dart';
import 'package:icarus/features/pusat_unduh/presentation/widgets/pusat_unduh_card.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class PusatUnduhScreen extends ConsumerWidget {
  const PusatUnduhScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(pusatUnduhControllerProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Pusat Unduh',
        leadingIcon: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        itemCount: items.length,
        itemBuilder: (_, i) => PusatUnduhCard(entity: items[i]),
      ),
    );
  }
}
