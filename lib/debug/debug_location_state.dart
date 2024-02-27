import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

part 'debug_location_state.freezed.dart';

@freezed
class DebugLocationState with _$DebugLocationState {
  const factory DebugLocationState({
    required PermissionStatus? status,
    required bool isLoading,
    required bool isCheckingIn,
    required bool isInitializedCurrentLocation,
    required double currentLat,
    required double currentLong,
    required double distanceInMeters,
  }) = _DebugLocationState;
}

const DebugLocationState defaultDebugLocationState = DebugLocationState(
  status: null,
  isLoading: false,
  isCheckingIn: false,
  isInitializedCurrentLocation: false,
  currentLat: 0.0,
  currentLong: 0.0,
  distanceInMeters: 0.0,
);

extension DebugLocationStateExtension on DebugLocationState {
  // 現在地と目的地の距離が30メートル以内のみオフィスにいる判定となる
  // TODO: 30メートルは仮の値なので適切な値に置き換える
  bool get isInOffice => distanceInMeters <= 30.0;
}
