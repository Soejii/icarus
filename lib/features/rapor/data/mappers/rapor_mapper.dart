import 'package:icarus/features/rapor/data/models/rapor_detail_report_model.dart';
import 'package:icarus/features/rapor/data/models/rapor_history_page_model.dart';
import 'package:icarus/features/rapor/data/models/rapor_period_model.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_detail_report_entity.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_history_page.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_period_entity.dart';

extension RaporDetailReportMapper on RaporDetailReportModel {
  RaporDetailReportEntity toEntity({required int index}) {
    return RaporDetailReportEntity(
      id: id,
      reportId: reportId,
      name: name,
      fileUrl: file,
      fallbackIndex: index,
    );
  }
}

extension RaporPeriodMapper on RaporPeriodModel {
  RaporPeriodEntity toEntity() {
    final details = <RaporDetailReportEntity>[];
    for (var i = 0; i < detailReport.length; i++) {
      details.add(detailReport[i].toEntity(index: i));
    }
    return RaporPeriodEntity(
      id: id,
      studentId: studentId,
      file: file,
      category: category,
      year: year,
      semester: semester,
      status: status,
      publishedAt: DateTime.tryParse(publishedAt ?? ''),
      revisionNotes: revisionNotes,
      name: name,
      createdAt: DateTime.tryParse(createdAt ?? ''),
      updatedAt: DateTime.tryParse(updatedAt ?? ''),
      detailReports: List.unmodifiable(details),
    );
  }
}

extension RaporHistoryPageMapper on RaporHistoryPageModel {
  RaporHistoryPage toEntity() {
    return RaporHistoryPage(
      items: items.map((m) => m.toEntity()).toList(growable: false),
      currentPage: currentPage,
      totalPages: totalPages,
    );
  }
}
