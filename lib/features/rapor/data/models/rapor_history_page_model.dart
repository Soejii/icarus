import 'package:icarus/features/rapor/data/models/rapor_period_model.dart';

class RaporHistoryPageModel {
  final List<RaporPeriodModel> items;
  final int currentPage;
  final int totalPages;

  const RaporHistoryPageModel({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });

  factory RaporHistoryPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>? ?? const [];
    return RaporHistoryPageModel(
      items: list
          .map((e) => RaporPeriodModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(growable: false),
      currentPage: json['current_page'] as int? ?? 1,
      totalPages: (json['last_page'] as int?) ?? (json['total_pages'] as int?) ?? 1,
    );
  }
}
