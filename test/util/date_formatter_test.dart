import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:pg_mobile/util/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    group('formatDate', () {
      test('現在時刻が正しくフォーマットされるか', () {
        final dateTime = DateTime.now();
        expect(DateFormatter.formatDate(dateTime), '0秒前');
      });

      test('1秒前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(const Duration(seconds: 1));
        expect(DateFormatter.formatDate(dateTime), '1秒前');
      });

      test('59秒前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(const Duration(seconds: 59));
        expect(DateFormatter.formatDate(dateTime), '59秒前');
      });

      test('1分前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(const Duration(minutes: 1));
        expect(DateFormatter.formatDate(dateTime), '1分前');
      });

      test('59分59秒前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(
          const Duration(minutes: 59, seconds: 59),
        );
        expect(DateFormatter.formatDate(dateTime), '59分前');
      });

      test('1時間前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(const Duration(hours: 1));
        expect(DateFormatter.formatDate(dateTime), '1時間前');
      });

      test('23時間59分59秒前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(
          const Duration(hours: 23, minutes: 59, seconds: 59),
        );
        expect(DateFormatter.formatDate(dateTime), '23時間前');
      });

      test('1日前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(
          const Duration(days: 1),
        );
        expect(DateFormatter.formatDate(dateTime), '1日前');
      });

      test('6日と23時間59分59秒前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(
          const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
        );
        expect(DateFormatter.formatDate(dateTime), '6日前');
      });

      test('7日前が正しくフォーマットされるか', () {
        final dateTime = DateTime.now().subtract(const Duration(days: 7));
        expect(
          DateFormatter.formatDate(dateTime),
          DateFormat('MM/dd').format(dateTime),
        );
      });

      test('今年の1月1日が正しくフォーマットされるか', () {
        final now = DateTime.now();
        final dateTime = DateTime(now.year, 1, 1, 0, 0, 0);
        expect(
          DateFormatter.formatDate(dateTime),
          DateFormat('MM/dd').format(dateTime),
        );
      });

      test('昨年の12月31日23時59分59秒が正しくフォーマットされるか', () {
        final now = DateTime.now();
        final dateTime = DateTime(now.year - 1, 12, 31, 23, 59, 59);
        expect(
          DateFormatter.formatDate(dateTime),
          DateFormat('yyyy/MM/dd').format(dateTime),
        );
      });
    });
  });
}
