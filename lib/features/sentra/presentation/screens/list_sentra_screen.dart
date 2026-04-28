import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/sentra/presentation/providers/sentra_controller.dart';
import 'package:icarus/features/sentra/presentation/widgets/sentra_card.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ListSentraScreen extends ConsumerWidget {
  const ListSentraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(sentraControllerProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Sentra',
        leadingIcon: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        itemCount: items.length,
        itemBuilder: (_, i) => SentraCard(entity: items[i]),
      ),
    );
  }
}
