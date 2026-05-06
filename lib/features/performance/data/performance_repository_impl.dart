import 'package:icarus/features/performance/data/datasources/performance_remote_data_source.dart';
import 'package:icarus/features/performance/data/mappers/exam_mapper.dart';
import 'package:icarus/features/performance/data/mappers/class_note_detail_mapper.dart';
import 'package:icarus/features/performance/data/mappers/note_mapper.dart';
import 'package:icarus/features/performance/domain/entities/class_note_detail_entity.dart';
import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/domain/entities/exam_entity.dart';
import 'package:icarus/shared/core/domain/types/exam_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceRemoteDataSource _dataSource;
  PerformanceRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<ExamEntity>>> getListExam({
    required ExamType examType,
    required int idStudent,
    required int page,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListExam(
            examType.name,
            page,
            idStudent,
          );
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<List<NoteEntity>>> getListStudentNote({
    required int idStudent,
    required int page,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListStudentNote(
            page,
            idStudent,
          );
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<List<NoteEntity>>> getListClassNote({
    required int idStudent,
    required int page,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListClassNote(
            page,
            idStudent,
          );
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<NoteEntity>> getStudentNoteDetail({required int noteId}) =>
      guard(
        () async {
          final model = await _dataSource.getStudentNoteDetail(noteId);
          return model.toEntity();
        },
      );

  @override
  Future<Result<ClassNoteDetailEntity>> getClassNoteDetail({
    required int noteId,
    required int idStudent,
  }) =>
      guard(
        () async {
          final model = await _dataSource.getClassNoteDetail(noteId, idStudent);
          return model.toEntity();
        },
      );
}
