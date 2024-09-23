import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'timeline_state.freezed.dart';

@freezed
class TimelineState with _$TimelineState {
  const factory TimelineState({
    required bool isLoading,
    required List<Status> statuses,
  }) = _TimelineState;
}

const TimelineState defaultTimelineState = TimelineState(
  isLoading: false,
  statuses: [],
);
