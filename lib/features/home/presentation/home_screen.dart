import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/announcement/presentation/widgets/announcement_widget.dart';
import 'package:gaia/features/home/presentation/widgets/digital_magazine_header.dart';
import 'package:gaia/shared/presentation/divider_card.dart';
import 'package:gaia/features/home/presentation/widgets/home_header_widget.dart';
import 'package:gaia/features/home/presentation/widgets/newest_exam_widget.dart';
import 'package:gaia/features/home/presentation/widgets/newest_quiz_widget.dart';
import 'package:gaia/features/home/presentation/widgets/rubric_entertainment_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const HomeHeaderWidget(),
            SizedBox(height: 50.h),
            const DigitalMagazineHeader(),
            SizedBox(height: 16.h),
            const AnnouncementWidget(),
            SizedBox(height: 16.h),
            const RubricEntertainmentWidget(),
            SizedBox(height: 16.h),
            const DividerCard(),
            SizedBox(height: 16.h),
            const NewestExamWidget(),
            SizedBox(height: 16.h),
            const DividerCard(),
            SizedBox(height: 16.h),
            const NewestQuizWidget(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
