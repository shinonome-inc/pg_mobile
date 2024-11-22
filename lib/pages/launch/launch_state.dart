import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch_state.freezed.dart';

@freezed
class LaunchState with _$LaunchState {
  const factory LaunchState({
    required bool isLoading,
  }) = _LaunchState;
}

const LaunchState initialLaunchState = LaunchState(
  isLoading: false,
);
