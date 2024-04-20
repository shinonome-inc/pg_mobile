import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'timeline.freezed.dart';

@freezed
class Timeline with _$Timeline {
  const factory Timeline({
    required List<Status> timelineStatus,
  }) = _Timeline;
}

const Timeline defaultTimeline = Timeline(
  timelineStatus: [],
);
