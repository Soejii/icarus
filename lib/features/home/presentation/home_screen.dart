import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/announcement/presentation/widgets/announcement_widget.dart';
import 'package:icarus/features/home/presentation/widgets/digital_magazine_header.dart';
import 'package:icarus/shared/presentation/divider_card.dart';
import 'package:icarus/features/home/presentation/widgets/home_header_widget.dart';
import 'package:icarus/features/home/presentation/widgets/rubric_entertainment_widget.dart';

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
          ],
        ),
      ),
    );
  }
}
