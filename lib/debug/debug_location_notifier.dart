import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
import 'package:pg_mobile/constants/locations.dart';
import 'package:pg_mobile/debug/debug_location_state.dart';
import 'package:pg_mobile/util/location_util.dart';

final debugLocationProvider =
    StateNotifierProvider<DebugLocationNotifier, DebugLocationState>(
  (ref) => DebugLocationNotifier(ref),
);

class DebugLocationNotifier extends StateNotifier<DebugLocationState> {
  DebugLocationNotifier(this.ref) : super(defaultDebugLocationState) {
    _checkLocationPermission();
    if (state.status == PermissionStatus.granted) {
      _setLocationListener();
    }
  }

  final Ref ref;

  final _location = location.Location();

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void _setLocationPermissionStatus(PermissionStatus status) {
    state = state.copyWith(status: status);
  }

  void _switchCheckingIn() {
    state = state.copyWith(isCheckingIn: !state.isCheckingIn);
  }

  void _setCurrentLatLong(double currentLat, double currentLong) {
    state = state.copyWith(
      currentLat: currentLat,
      currentLong: currentLong,
    );
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationAlways.status;
    _setLocationPermissionStatus(status);
    debugPrint('check location permission: ${state.status}');
  }

  Future<void> reload() async {
    if (state.isLoading) return;
    _setLoading(true);
    print('reload');
    // 再読み込みを行ったことをユーザーに伝えるために1秒待機
    await Future.delayed(const Duration(seconds: 1));
    await _checkLocationPermission();
    _setLoading(false);
  }

  Future<void> checkInCheckOut() async {
    if (state.isLoading) return;
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _switchCheckingIn();
    _setLoading(false);
  }

  void _setLocationListener() {
    _location.onLocationChanged.listen(_locationListener);
  }

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
  }
}
