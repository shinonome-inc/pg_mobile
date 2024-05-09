import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pg_mobile/models/mastodon/timeline.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

final timelineProvider =
    StateNotifierProvider<TimelineNotifier, Timeline>((ref) {
  return TimelineNotifier();
});

class TimelineNotifier extends StateNotifier<Timeline> {
  TimelineNotifier() : super(const Timeline());

  Future<void> fetchTimeline() async {
    final statusTimeline = await MastodonRepository.instance.fetchStatus();
    final currentStatusList = [...state.timelineStatus];
    currentStatusList.addAll(statusTimeline);
    state = state.copyWith(timelineStatus: currentStatusList);
  }
}
