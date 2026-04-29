import 'package:icarus/features/konseling/data/models/konseling_detail_model.dart';
import 'package:icarus/features/konseling/data/models/konseling_list_model.dart';
import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/shared/utils/date_helper.dart';

extension KonselingListMapper on KonselingListModel {
  KonselingEntity toEntity(KonselingType type) => KonselingEntity(
        id: id,
        type: type,
        topic: topic ?? '-',
        date: formatIndoDate(date),
        durationMinutes: duration ?? 0,
      );
}

extension KonselingDetailMapper on KonselingDetailModel {
  KonselingEntity toEntity() => KonselingEntity(
        id: id,
        type: _parseType(type),
        topic: topic ?? '-',
        date: formatIndoDate(date),
        durationMinutes: duration ?? 0,
        teacherName: teacherName,
        approach: approach,
        description: description,
        evaluation: evaluasi,
        attachmentUrl: attachment,
      );
}

KonselingType _parseType(String? value) => switch (value) {
      'student' => KonselingType.student,
      'parent' => KonselingType.parent,
      'home_visit' => KonselingType.homeVisit,
      _ => KonselingType.student,
    };
