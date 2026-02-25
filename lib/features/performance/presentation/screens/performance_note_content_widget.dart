import 'package:flutter/material.dart';

import 'package:icarus/features/performance/presentation/widgets/performance_note_card.dart';

class PerformanceNoteContentWidget extends StatelessWidget {
  const PerformanceNoteContentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PerformanceNoteCard(),
        PerformanceNoteCard(),
        PerformanceNoteCard(),
      ],
    );
  }
}
