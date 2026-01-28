import 'package:intl/intl.dart';

String formatIndoDate(String? dateStr) {
  try {
    return DateFormat.yMMMMd('id_ID').format(DateTime.parse(dateStr ?? ''));
  } catch (_) {
    return '-';
  }
}
