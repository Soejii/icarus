class SafeDateParser {
  static DateTime? parse(String? s) {
    if (s == null || s.isEmpty || s.startsWith('0000')) return null;
    try {
      return DateTime.parse(s.replaceFirst(' ', 'T'));
    } catch (_) {
      return null;
    }
  }
}
