import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
import 'package:pg_mobile/constants/locations.dart';
import 'package:pg_mobile/debug/location/debug_location_state.dart';
import 'package:pg_mobile/extensions/permission_status_extension.dart';
import 'package:pg_mobile/util/location_util.dart';

final debugLocationProvider =
    StateNotifierProvider<DebugLocationNotifier, DebugLocationState>(
  (ref) => DebugLocationNotifier(ref),
);

class DebugLocationNotifier extends StateNotifier<DebugLocationState> {
  DebugLocationNotifier(this.ref) : super(defaultDebugLocationState) {
    _checkLocationPermission();
  }

  final Ref ref;

  final _location = location.Location();

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void _switchCheckingIn() {
    state = state.copyWith(isCheckingIn: !state.isCheckingIn);
  }

  void _setIsInitializedCurrentLocation(bool value) {
    state = state.copyWith(isInitializedCurrentLocation: value);
  }

  void _setCurrentLatLong(double currentLat, double currentLong) {
    state = state.copyWith(
      currentLat: currentLat,
      currentLong: currentLong,
    );
  }

  Future<void> _setLocationPermissionStatus(PermissionStatus status) async {
    state = state.copyWith(locationPermissionStatus: status);
    if (state.locationPermissionStatus.isGranted) {
      _location.onLocationChanged.listen(_locationListener);
    }
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationAlways.status;
    debugPrint('Location permission status: $status');
    _setLocationPermissionStatus(status);
  }

  /// 現在の位置情報の権限を状態管理に反映させるために再読み込みを行う
  Future<void> reload() async {
    if (state.isLoading) return;
    _setLoading(true);
    // 再読み込みを行ったことをユーザーに伝えるために1秒待機
    await Future.delayed(const Duration(seconds: 1));
    await _checkLocationPermission();
    if (state.locationPermissionStatus.isGranted) return;
    _setLoading(false);
  }

  Future<void> checkInCheckOut() async {
    if (state.isLoading) return;
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _switchCheckingIn();
    _setLoading(false);
  }

  /// 端末の位置情報が更新されるたびに呼び出されるListener
  void _locationListener(location.LocationData currentLocation) {
    if (currentLocation.latitude == null || currentLocation.longitude == null) {
      return;
    }
    _setCurrentLatLong(currentLocation.latitude!, currentLocation.longitude!);
    state = state.copyWith(
      distanceInMeters: LocationUtil.distanceInMeters(
        currentLocation,
        Locations.debugTarget,
      ),
    );
    if (!state.isInitializedCurrentLocation) {
      _setIsInitializedCurrentLocation(true);
      _setLoading(false);
    }
  }
}
