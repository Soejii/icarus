import 'package:icarus/features/sentra/data/models/sentra_model.dart';
import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/shared/utils/date_helper.dart';

extension SentraMapper on SentraModel {
  SentraEntity toEntity() => SentraEntity(
        id: id,
        name: sentraRombel?.sentra?.sentraName ?? '-',
        date: formatIndoDate(createdAt),
        classGroup: sentraRombel?.name ?? '-',
        teacherName: teacher?.name ?? '-',
        note: note ?? '-',
        score: int.tryParse(score ?? '0') ?? 0,
        description: description ?? '-',
      );
}
