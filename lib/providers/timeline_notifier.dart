import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/states/timeline_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/util/status_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timeline_notifier.g.dart';

@riverpod
class TimelineNotifier extends _$TimelineNotifier {
  @override
  TimelineState build() {
    return initialTimelineState;
  }

  void reset() {
    state = initialTimelineState;
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setStatuses(List<Status> statuses) {
    state = state.copyWith(statuses: statuses);
  }

  void setStatus(Status status) {
    final statuses = state.statuses.map((element) {
      return element.id == status.id ? status : element;
    }).toList();
    setStatuses(statuses);
  }

  void addStatuses(List<Status> statuses) {
    setStatuses([...statuses, ...state.statuses]);
  }

  void addStatus(Status status) {
    setStatuses([status, ...state.statuses]);
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
    addStatuses(fetchedStatuses);
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
      final repliedStatus = StatusUtil.findStatusFromId(
        state.statuses,
        inReplyToId,
      );
      setStatus(
        repliedStatus.copyWith(repliesCount: repliedStatus.favouritesCount + 1),
      );
    }
    addStatus(postedStatus);
  }

  Future<void> onTapBoost(Status tappedStatus) async {
    if (tappedStatus.reblogged == null || state.isLoading) return;
    setLoading(true);
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
    setLoading(false);
    setStatus(status);
  }

  Future<void> onTapFavorite(Status tappedStatus) async {
    if (tappedStatus.favourited == null || state.isLoading) return;
    setLoading(true);
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
    setLoading(false);
    setStatus(status);
  }
}
