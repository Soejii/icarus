import 'package:gaia/features/subject/data/models/detail_sub_module_model.dart';
import 'package:gaia/features/subject/domain/entities/detail_sub_module_entity.dart';

extension DetailSubModuleMapper on DetailSubModuleModel {
  DetailSubModuleEntity toEntity() => DetailSubModuleEntity(
        id: id,
        data: description,
        title: title,
        date: publishDate ?? createdAt,
        link: file
      );
}
