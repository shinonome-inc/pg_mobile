import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pg_mobile/models/mastodon/timeline.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

final timelineProvider =
    StateNotifierProvider<TimelineNotifier, Timeline>((ref) {
  return TimelineNotifier();
});

class TimelineNotifier extends StateNotifier<Timeline> {
  TimelineNotifier() : super(defaultTimeline);

  void reset() {
    state = defaultTimeline;
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> onRefresh() async {
    reset();
    await fetchTimeline();
  }

  Future<void> fetchTimeline() async {
    final fetchedStatuses = await MastodonRepository.instance.fetchStatus();
    final statuses = [...state.statuses];
    statuses.addAll(fetchedStatuses);
    state = state.copyWith(statuses: statuses);
  }
}
