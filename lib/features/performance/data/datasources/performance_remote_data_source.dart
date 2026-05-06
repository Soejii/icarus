import 'package:dio/dio.dart';
import 'package:icarus/features/performance/data/models/class_note_detail_model.dart';
import 'package:icarus/features/performance/data/models/exam_model.dart';
import 'package:icarus/features/performance/data/models/note_model.dart';

class PerformanceRemoteDataSource {
  final Dio _dio;
  PerformanceRemoteDataSource(this._dio);

  Future<List<ExamModel>> getListExam(
    String? type,
    int page,
    int idStudent,
  ) async {
    final res = await _dio.get(
      '/performance/get-all-exam/$idStudent',
      queryParameters: {
        'exam_type': type ?? 'all',
        'paginate': true,
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

  Future<List<NoteModel>> getListStudentNote(
    int page,
    int idStudent,
  ) async {
    final res = await _dio.get(
      '/student/daily-notes/$idStudent',
      queryParameters: {
        'paginate': true,
        'page': page,
      },
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map(
          (e) => NoteModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<List<NoteModel>> getListClassNote(
    int page,
    int idStudent,
  ) async {
    final res = await _dio.get(
      '/class-daily-notes/get-class-daily-notes/$idStudent',
      queryParameters: {
        'paginate': true,
        'page': page,
      },
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map(
          (e) => NoteModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<NoteModel> getStudentNoteDetail(int noteId) async {
    final res = await _dio.get('/student/detail-daily-notes/$noteId');
    final data =
        (res.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
    return NoteModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<ClassNoteDetailModel> getClassNoteDetail(
    int noteId,
    int idStudent,
  ) async {
    final res = await _dio.get(
      '/class-daily-notes/get-class-daily-note-detail/$noteId/$idStudent',
    );
    final data =
        (res.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
    return ClassNoteDetailModel.fromJson(Map<String, dynamic>.from(data));
  }
}
