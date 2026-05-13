import 'package:icarus/features/finance/domain/entities/canteen_item_entity.dart';

class CanteenItemParser {
  static List<CanteenItemEntity> parse(String? listItem) {
    if (listItem == null || listItem.isEmpty) return [];
    return listItem
        .split('\n')
        .where((line) => line.trim().startsWith('-'))
        .map(_parseLine)
        .whereType<CanteenItemEntity>()
        .toList();
  }

  static CanteenItemEntity? _parseLine(String line) {
    final qtyStart = line.lastIndexOf('(');
    final qtyEnd = line.lastIndexOf(')');
    if (qtyStart < 0 || qtyEnd < 0) return null;
    final name = line.substring(2, qtyStart).trim();
    final qty = int.tryParse(line.substring(qtyStart + 1, qtyEnd)) ?? 1;
    final priceStr = line
        .substring(qtyEnd + 1)
        .replaceAll('Rp.', '')
        .replaceAll('Rp', '')
        .trim();
    final price = int.tryParse(priceStr.replaceAll('.', '')) ?? 0;
    return CanteenItemEntity(name: name, quantity: qty, price: price);
  }
}
