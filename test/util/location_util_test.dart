import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:pg_mobile/util/location_util.dart';

void main() {
  group('LocationUtil', () {
    test('convertToLocationDataメソッドでdouble型の緯度と経度をLocationData型に変換できるか', () {
      const latitude = 35.7020165;
      const longitude = 139.7441266;
      final locationData = LocationUtil.convertToLocationData(
        latitude,
        longitude,
      );

      expect(locationData.latitude, latitude);
      expect(locationData.longitude, longitude);
    });

    test('distanceInMetersメソッドによって2つの座標間の距離（m）を計算できているか', () {
      final startLocation = LocationData.fromMap(
          {'latitude': 35.7020165, 'longitude': 139.7441266});
      final endLocation = LocationData.fromMap(
          {'latitude': 35.7019457, 'longitude': 139.7393167});

      // 計算ツールによって計算した2点間の距離
      // https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/bl2stf.html
      const expectedDistance = 435.375;

      final distance = LocationUtil.distanceInMeters(
        startLocation,
        endLocation,
      );

      // closeTo関数で1mまでの誤差を許容
      expect(distance, closeTo(expectedDistance, 1));
    });

    test('distanceInMetersメソッドの座標にnullが含まれていた場合に例外がスローされるか', () {
      final startLocation = LocationUtil.convertToLocationData(
        35.7020165,
        139.7441266,
      );
      final endLocation = LocationData.fromMap({
        'latitude': null,
        'longitude': 139.7449061,
      });

      expect(
        () => LocationUtil.distanceInMeters(startLocation, endLocation),
        throwsException,
      );
    });
  });
}
