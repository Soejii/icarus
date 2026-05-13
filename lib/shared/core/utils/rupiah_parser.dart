class RupiahParser {
  static int toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    final s = value
        .toString()
        .replaceAll('Rp.', '')
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('+', '')
        .replaceAll('-', '')
        .trim();
    return int.tryParse(s) ?? 0;
  }

  static bool isDebit(dynamic value) {
    final s = value?.toString() ?? '';
    return s.startsWith('-');
  }
}
