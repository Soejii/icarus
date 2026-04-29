import 'package:icarus/features/pusat_unduh/data/models/pusat_unduh_model.dart';
import 'package:icarus/features/pusat_unduh/domain/entities/pusat_unduh_entity.dart';

extension PusatUnduhMapper on PusatUnduhModel {
  PusatUnduhEntity toEntity() => PusatUnduhEntity(
        id: id,
        title: title ?? '-',
        uploader: user?.name ?? '-',
        startDate: startDate ?? '-',
        endDate: endDate ?? '-',
        fileUrl: file ?? '',
      );
}
