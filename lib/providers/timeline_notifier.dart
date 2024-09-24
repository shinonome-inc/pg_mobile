import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/states/timeline_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timeline_notifier.g.dart';

@riverpod
class TimelineNotifier extends _$TimelineNotifier {
  @override
  TimelineState build() {
    return defaultTimelineState;
  }

  void reset() {
    state = defaultTimelineState;
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> onRefresh() async {
    if (state.isLoading) return;
    reset();
    await fetchTimeline();
  }

  Future<void> fetchTimeline() async {
    if (state.isLoading) return;
    setLoading(true);
    final fetchedStatuses = await MastodonRepository.instance.fetchStatus();
    setLoading(false);
    final statuses = [...state.statuses];
    statuses.addAll(fetchedStatuses);
    state = state.copyWith(statuses: statuses);
  }

  Future<void> postStatus({
    required String text,
    String? inReplyToId,
  }) async {
    if (state.isLoading) return;
    setLoading(true);
    Status postedStatus;
    try {
      postedStatus = await MastodonRepository.instance.postNewStatus(
        text: text,
        mediaIds: [],
        poll: [],
        inReplyToId: inReplyToId,
      );
    } catch (e) {
      throw Exception('Failed to send: $e');
    } finally {
      setLoading(false);
    }
    if (inReplyToId != null) {
      List<Status> statuses = state.statuses
          .map(
            (status) => status.id == inReplyToId
                ? status.copyWith(repliesCount: status.repliesCount + 1)
                : status,
          )
          .toList();
      state = state.copyWith(statuses: statuses);
    }
    state = state.copyWith(
      statuses: [postedStatus, ...state.statuses],
    );
  }

  Future<void> onTapBoost(Status tappedStatus) async {
    if (tappedStatus.reblogged == null) return;
    Status status;
    if (tappedStatus.reblogged!) {
      status = await MastodonRepository.instance.undoBoostStatus(
        tappedStatus.id,
      );
    } else {
      status = await MastodonRepository.instance.boostStatus(
        tappedStatus.id,
      );
    }
    List<Status> statuses = state.statuses;
    statuses.firstWhere((element) => element.id == status.id);
    state = state.copyWith(statuses: statuses);
  }

  Future<void> onTapFavorite(Status tappedStatus) async {
    if (tappedStatus.favourited == null) return;
    Status status;
    if (tappedStatus.favourited!) {
      status = await MastodonRepository.instance.undoFavoriteStatus(
        tappedStatus.id,
      );
    } else {
      status = await MastodonRepository.instance.favoriteStatus(
        tappedStatus.id,
      );
    }
    List<Status> statuses = state.statuses;
    statuses.firstWhere((element) => element.id == status.id);
    state = state.copyWith(statuses: statuses);
  }
}
