import 'package:gaia/features/subject/domain/entities/sub_module_entity.dart';

class ModuleEntity {
  final int id;
  final String? title;
  final int? subModuleCount;
  final int? examCount;
  final int? quizCount;
  final List<SubModuleEntity>? listSubModule;

  ModuleEntity({
    required this.id,
    required this.title,
    required this.subModuleCount,
    required this.examCount,
    required this.quizCount,
    required this.listSubModule,
  });
}
