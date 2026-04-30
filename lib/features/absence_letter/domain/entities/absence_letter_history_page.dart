import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';

class AbsenceLetterHistoryPage {
  final List<AbsenceLetterEntity> items;
  final int currentPage;
  final int totalPages;

  const AbsenceLetterHistoryPage({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });
}
