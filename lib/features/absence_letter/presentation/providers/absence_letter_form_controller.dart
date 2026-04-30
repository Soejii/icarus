import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'absence_letter_form_controller.g.dart';

class AbsenceLetterFormState {
  final String status;
  final String notes;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? evidencePath;

  const AbsenceLetterFormState({
    this.status = 'sick',
    this.notes = '',
    this.startDate,
    this.endDate,
    this.evidencePath,
  });

  AbsenceLetterFormState copyWith({
    String? status,
    String? notes,
    DateTime? startDate,
    DateTime? endDate,
    String? evidencePath,
    bool clearEvidence = false,
  }) {
    return AbsenceLetterFormState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      evidencePath: clearEvidence ? null : evidencePath ?? this.evidencePath,
    );
  }
}

@Riverpod(keepAlive: true)
class AbsenceLetterFormController extends _$AbsenceLetterFormController {
  @override
  AbsenceLetterFormState build() => const AbsenceLetterFormState();

  void setStatus(String status) {
    state = state.copyWith(status: status);
  }

  void setNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void setStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
  }

  void setEndDate(DateTime date) {
    state = state.copyWith(endDate: date);
  }

  void setEvidencePath(String path) {
    state = state.copyWith(evidencePath: path);
  }

  void clearEvidence() {
    state = state.copyWith(clearEvidence: true);
  }

  void reset() {
    state = const AbsenceLetterFormState();
  }
}
