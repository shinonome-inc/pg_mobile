import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

/// 位置情報関連のユーティリティークラス
class LocationUtil {
  LocationUtil._();

  /// double型の緯度と経度の[LocationData]型への変換を行う。
  static LocationData convertToLocationData(double latitude, double longitude) {
    return LocationData.fromMap({
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  /// 2点間の座標の距離（メートル）の計算を実行する。
  static double distanceInMeters(
    LocationData startLocation,
    LocationData endLocation,
  ) {
    final isCompleteLocationData = startLocation.latitude != null &&
        startLocation.longitude != null &&
        endLocation.latitude != null &&
        endLocation.longitude != null;
    if (!isCompleteLocationData) {
      throw Exception('One or more input location data is null.');
    }
    final result = Geolocator.distanceBetween(
      endLocation.latitude!,
      endLocation.longitude!,
      startLocation.latitude!,
      startLocation.longitude!,
    );
    return result;
  }
}
