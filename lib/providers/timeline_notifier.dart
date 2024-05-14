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

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> onRefresh() async {
    if (state.isLoading) return;
    reset();
    await fetchTimeline();
  }

  Future<void> fetchTimeline() async {
    if (state.isLoading) return;
    _setLoading(true);
    final fetchedStatuses = await MastodonRepository.instance.fetchStatus();
    _setLoading(false);
    final statuses = [...state.statuses];
    statuses.addAll(fetchedStatuses);
    state = state.copyWith(statuses: statuses);
  }
}
