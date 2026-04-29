import 'package:icarus/features/sentra/data/models/sentra_model.dart';
import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/shared/utils/date_helper.dart';

extension SentraMapper on SentraModel {
  SentraEntity toEntity() => SentraEntity(
        id: id,
        namaSentra: sentraRombel?.sentra?.sentraName ?? '-',
        tanggal: formatIndoDate(createdAt),
        rombel: sentraRombel?.name ?? '-',
        namaGuru: teacher?.name ?? '-',
        keterangan: note ?? '-',
        nilai: int.tryParse(score ?? '0') ?? 0,
        deskripsi: description ?? '-',
      );
}
