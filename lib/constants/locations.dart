import 'package:pg_mobile/util/location_util.dart';

class Locations {
  Locations._();

  /// PlayGround東京オフィスの緯度
  static const debugTargetLat = 35.7021178;

  /// PlayGround東京オフィスの経度
  static const debugTargetLong = 139.7449061;

  /// PlayGround東京オフィスの座標
  static final debugTarget = LocationUtil.convertToLocationData(
    debugTargetLat,
    debugTargetLong,
  );
}
