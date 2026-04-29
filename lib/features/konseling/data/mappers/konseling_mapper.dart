import 'package:icarus/features/konseling/data/models/konseling_detail_model.dart';
import 'package:icarus/features/konseling/data/models/konseling_list_model.dart';
import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/shared/utils/date_helper.dart';

extension KonselingListMapper on KonselingListModel {
  KonselingEntity toEntity(KonselingType type) => KonselingEntity(
        id: id,
        type: type,
        topik: topic ?? '-',
        tanggal: formatIndoDate(date),
        durasiMenit: duration ?? 0,
      );
}

extension KonselingDetailMapper on KonselingDetailModel {
  KonselingEntity toEntity() => KonselingEntity(
        id: id,
        type: _parseType(type),
        topik: topic ?? '-',
        tanggal: formatIndoDate(date),
        durasiMenit: duration ?? 0,
        namaGuru: teacherName,
        pendekatan: approach,
        deskripsi: description,
        evaluasi: evaluasi,
        lampiranUrl: attachment,
      );
}

KonselingType _parseType(String? value) => switch (value) {
      'student' => KonselingType.siswa,
      'parent' => KonselingType.orangTua,
      'home_visit' => KonselingType.homeVisit,
      _ => KonselingType.siswa,
    };
