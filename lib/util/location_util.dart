import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationUtil {
  LocationUtil._();

  static LocationData convertToLocationData(double latitude, double longitude) {
    return LocationData.fromMap({
      'latitude': latitude,
      'longitude': longitude,
    });
  }

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
