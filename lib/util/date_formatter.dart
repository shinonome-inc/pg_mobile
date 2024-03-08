import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatPGNDate(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
