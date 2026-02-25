import 'package:flutter/material.dart';
import 'package:icarus/features/performance/domain/types/performance_type.dart';
import 'package:icarus/features/performance/presentation/widgets/performance_card.dart';

class PerformanceContentWidget extends StatelessWidget {
  const PerformanceContentWidget({super.key, required this.type});
  final PerformanceType type;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PerformanceCard(type: type),
        PerformanceCard(type: type),
        PerformanceCard(type: type),
      ],
    );
  }
}
