import 'package:dio/dio.dart';
import 'package:icarus/features/absence_letter/data/models/absence_letter_model.dart';
import 'package:icarus/features/absence_letter/domain/entities/submit_absence_letter_request.dart';

class AbsenceLetterRemoteDataSource {
  final Dio _dio;

  const AbsenceLetterRemoteDataSource(this._dio);

  Future<AbsenceLetterHistoryPageModel> getHistory({
    required int studentId,
    required String type,
    int page = 1,
  }) async {
    final res = await _dio.get(
      '/attendance-student/history-attendance',
      queryParameters: {
        'student_id': studentId,
        'type': type,
        'page': page,
      },
    );
    return AbsenceLetterHistoryPageModel.fromJson(
      Map<String, dynamic>.from(res.data['data'] as Map),
    );
  }

  Future<void> submit(SubmitAbsenceLetterRequest request) async {
    final formData = FormData.fromMap({
      'student_id': request.studentId,
      'status': request.status,
      'evidence': await MultipartFile.fromFile(request.evidencePath),
      'notes': request.notes,
      'start_date': request.startDate,
      'end_date': request.endDate,
    });

    await _dio.post(
      '/attendance-student/submit-attendance',
      data: formData,
    );
  }
}
