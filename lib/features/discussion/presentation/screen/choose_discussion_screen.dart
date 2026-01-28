import 'package:flutter/material.dart';
import 'package:gaia/features/discussion/presentation/widgets/choose_discussion_button.dart';

import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';

class ChooseDiscussionScreen extends StatelessWidget {
  const ChooseDiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  CustomAppBarWidget(
        title: 'Pilih Diskusi',
        leadingIcon: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           ChooseDiscussionButton(index: 0), // 0 means navigate to subject discussion
           ChooseDiscussionButton(index: 1), // while 1 means navigate to class discussion
        ],
      ),
    );
  }
}
