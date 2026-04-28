import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/features/konseling/presentation/providers/konseling_controller.dart';
import 'package:icarus/features/konseling/presentation/widgets/konseling_card.dart';

class KonselingListContent extends ConsumerWidget {
  const KonselingListContent({super.key, required this.type});

  final KonselingType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(konselingControllerProvider(type));

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: items.length,
      itemBuilder: (_, i) => KonselingCard(entity: items[i]),
    );
  }
}
