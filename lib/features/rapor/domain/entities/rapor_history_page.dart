import 'package:icarus/features/rapor/domain/entities/rapor_period_entity.dart';

class RaporHistoryPage {
  final List<RaporPeriodEntity> items;
  final int currentPage;
  final int totalPages;

  const RaporHistoryPage({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });
}
