import 'package:intl/intl.dart';

String formatRupiah(int? amount) {
  try {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(amount ?? 0);
  } catch (_) {
    return '-';
  }
}
