import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatPastDate(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inSeconds < 1) {
      return '今';
    } else if (diff.inSeconds < 60) {
      return '${diff.inSeconds}秒前';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}分前';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}時間前';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}日前';
    } else if (now.year == dateTime.year) {
      return DateFormat('MM/dd').format(dateTime);
    } else {
      return DateFormat('yyyy/MM/dd').format(dateTime);
    }
  }

  static String formatPGNDate(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
