import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence_letter_model.freezed.dart';
part 'absence_letter_model.g.dart';

@freezed
class AbsenceLetterModel with _$AbsenceLetterModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AbsenceLetterModel({
    required int id,
    required int studentId,
    String? status,
    String? date,
    String? evidencePath,
    String? notes,
    String? createdAt,
    String? updatedAt,
  }) = _AbsenceLetterModel;

  factory AbsenceLetterModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenceLetterModelFromJson(json);
}

class AbsenceLetterHistoryPageModel {
  final List<AbsenceLetterModel> items;
  final int currentPage;
  final int totalPages;

  const AbsenceLetterHistoryPageModel({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });

  factory AbsenceLetterHistoryPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? const [];
    return AbsenceLetterHistoryPageModel(
      items: data
          .map(
            (item) => AbsenceLetterModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(growable: false),
      currentPage: json['current_page'] as int? ?? 1,
      totalPages:
          (json['total_pages'] as int?) ?? (json['last_page'] as int?) ?? 1,
    );
  }
}
