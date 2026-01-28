import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/discussion/domain/entity/discussion_entity.dart';
import 'package:gaia/features/discussion/presentation/widgets/comment_card.dart';
import 'package:gaia/features/discussion/presentation/widgets/discussion_card.dart';

class DiscussionPostCard extends StatelessWidget {
  const DiscussionPostCard({super.key, required this.entity});
  final DiscussionEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DiscussionCard(
          isDetail: false,
          entity: entity.poster,
        ),
        if (entity.comment != null)
          Column(
            children: [
              SizedBox(height: 10.h),
              CommentCard(entity: entity.comment),
            ],
          ),
      ],
    );
  }
}
