import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/announcement/presentation/widgets/announcement_widget.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/home/presentation/widgets/digital_magazine_header.dart';
import 'package:icarus/features/home/presentation/widgets/home_header_widget.dart';
import 'package:icarus/features/home/presentation/widgets/nilai_murid_widget.dart';
import 'package:icarus/features/home/presentation/widgets/rubric_entertainment_widget.dart';
import 'package:icarus/features/home/presentation/widgets/tagihan_widget.dart';
import 'package:icarus/shared/core/domain/types/exam_type.dart';
import 'package:icarus/shared/presentation/divider_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pre-fetch children and auto-select first on load
    ref.listen(childListControllerProvider, (_, next) {
      next.whenData((children) {
        if (children.isNotEmpty && ref.read(selectedChildProvider) == null) {
          ref.read(selectedChildProvider.notifier).select(children.first);
        }
      });
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            HomeHeaderWidget(),
            DigitalMagazineHeader(),
            AnnouncementWidget(),
            RubricEntertainmentWidget(),
            DividerCard(),
            NilaiMuridWidget(type: ExamType.cbt),
            DividerCard(),
            TagihanWidget(),
          ],
        ),
      ),
    );
  }
}
