import 'package:icarus/features/absence_letter/data/models/absence_letter_model.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_history_page.dart';

extension AbsenceLetterMapper on AbsenceLetterModel {
  AbsenceLetterEntity toEntity() {
    return AbsenceLetterEntity(
      id: id,
      studentId: studentId,
      status: status ?? '-',
      date: date ?? '-',
      notes: notes,
      evidencePath: evidencePath,
      createdAt: DateTime.tryParse(createdAt ?? ''),
      updatedAt: DateTime.tryParse(updatedAt ?? ''),
    );
  }
}

extension AbsenceLetterHistoryPageMapper on AbsenceLetterHistoryPageModel {
  AbsenceLetterHistoryPage toEntity() {
    return AbsenceLetterHistoryPage(
      items: items.map((item) => item.toEntity()).toList(growable: false),
      currentPage: currentPage,
      totalPages: totalPages,
    );
  }
}
