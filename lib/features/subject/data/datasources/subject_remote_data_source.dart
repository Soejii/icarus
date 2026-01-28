import 'package:dio/dio.dart';
import 'package:gaia/features/activity/data/models/exam_model.dart';
import 'package:gaia/features/task/data/models/task_model.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/features/subject/data/models/detail_sub_module_model.dart';
import 'package:gaia/features/subject/data/models/media_model.dart';
import 'package:gaia/features/subject/data/models/module_model.dart';
import 'package:gaia/features/subject/data/models/subject_model.dart';

class SubjectRemoteDataSource {
  final Dio _dio;
  SubjectRemoteDataSource(this._dio);

  Future<List<SubjectModel>> getAllSubject() async {
    final res = await _dio.get(
      '/subjects',
    );
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => SubjectModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<List<ModuleModel>> getModule(int subjectId) async {
    final res = await _dio.get(
      '/subject/list-modules',
      queryParameters: {
        'subject_id': subjectId,
      },
    );
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => ModuleModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<List<MediaModel>> getLearningMedia(int subjectId) async {
    final res = await _dio.get(
      '/subject/list-learning-media',
      queryParameters: {
        'subject_id': subjectId,
      },
    );
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => MediaModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<List<ExamModel>> getListSubjectExam(
    int subjectId,
    ExamType examType,
    int page,
  ) async {
    final res = await _dio.get(
      '/subject/list-exam',
      queryParameters: {
        'subject_id': subjectId,
        'exam_type': examType.name,
        'page': page,
      },
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map(
          (e) => ExamModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<List<TaskModel>> getListTask(int page, int subjectId) async {
    final res = await _dio.get(
      '/task/all',
      queryParameters: {
        'paginate': true,
        'subject_id': subjectId,
        'page': page,
        'perPage': 10,
      },
    );
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => TaskModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<DetailSubModuleModel> getDetailSubModule(int id) async {
    final res = await _dio.get('/subject/detail-sub-module',
        queryParameters: {'sub_module_id': id});
    final data = DetailSubModuleModel.fromJson(res.data['data']);
    return data;
  }

  Future<SubjectModel> getDetailSubject(int idSubject) async {
    final res = await _dio.get('/subjects/$idSubject');
    final data = SubjectModel.fromJson(res.data['data']);
    return data;
  }
}
