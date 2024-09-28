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

  void _reset() {
    state = initialTimelineState;
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void _setStatuses(List<Status> statuses) {
    state = state.copyWith(statuses: statuses);
  }

  void _setStatus(Status status) {
    final statuses = state.statuses.map((element) {
      return element.id == status.id ? status : element;
    }).toList();
    _setStatuses(statuses);
  }

  void _addStatuses(List<Status> statuses) {
    _setStatuses([...statuses, ...state.statuses]);
  }

  void _addStatus(Status status) {
    _setStatuses([status, ...state.statuses]);
  }

  Future<void> onRefresh() async {
    if (state.isLoading) return;
    _reset();
    await fetchTimeline();
  }

  Future<void> fetchTimeline() async {
    if (state.isLoading) return;
    setLoading(true);
    final fetchedStatuses = await MastodonRepository.instance.fetchStatus();
    setLoading(false);
    _addStatuses(fetchedStatuses);
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
      _setStatus(
        repliedStatus.copyWith(repliesCount: repliedStatus.favouritesCount + 1),
      );
    }
    _addStatus(postedStatus);
  }

  Future<void> onTapBoost(Status tappedStatus) async {
    if (tappedStatus.reblogged == null || state.isLoading) return;
    setLoading(true);
    Status status;
    if (tappedStatus.reblogged!) {
      status = await MastodonRepository.instance.undoBoostStatus(
        tappedStatus.id,
      );
      status = status.copyWith(reblogsCount: status.reblogsCount - 1);
      print(
        'reblogged: ${status.reblogged}, reblogsCount: ${status.reblogsCount}',
      );
    } else {
      status = await MastodonRepository.instance.boostStatus(
        tappedStatus.id,
      );
      status = status.copyWith(reblogsCount: status.reblogsCount + 1);
      print(
        'reblogged: ${status.reblogged}, reblogsCount: ${status.reblogsCount}',
      );
    }
    setLoading(false);
    _setStatus(status);
  }

  Future<void> onTapFavorite(Status tappedStatus) async {
    if (tappedStatus.favourited == null || state.isLoading) return;
    setLoading(true);
    Status status;
    if (tappedStatus.favourited!) {
      status = await MastodonRepository.instance.undoFavoriteStatus(
        tappedStatus.id,
      );
      status = status.copyWith(favouritesCount: status.favouritesCount - 1);
    } else {
      status = await MastodonRepository.instance.favoriteStatus(
        tappedStatus.id,
      );
    }
    setLoading(false);
    _setStatus(status);
  }
}
