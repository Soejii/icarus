import 'package:gaia/features/subject/data/models/module_model.dart';
import 'package:gaia/features/subject/data/models/sub_module_model.dart';
import 'package:gaia/features/subject/domain/entities/module_entity.dart';
import 'package:gaia/features/subject/domain/entities/sub_module_entity.dart';

extension ModuleMapper on ModuleModel {
  ModuleEntity toEntity() => ModuleEntity(
        id: id,
        title: title,
        examCount: examCount,
        quizCount: quizCount,
        subModuleCount: subModuleCount,
        listSubModule: subModule?.map((e) => e.toEntity()).toList() ?? [],
      );
}

extension SubModuleMapper on SubModuleModel {
  SubModuleEntity toEntity() => SubModuleEntity(
        id: id,
        title: title,
        isUploaded: isUploaded == 1,
      );
}
