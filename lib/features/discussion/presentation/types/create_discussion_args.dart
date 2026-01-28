import 'package:gaia/features/discussion/presentation/types/create_discussion_type.dart';

class CreateDiscussionArgs {
  final CreateDiscussionType type; // "class" or "subject"
  final int? subjectId;

  const CreateDiscussionArgs({required this.type, this.subjectId});
}
