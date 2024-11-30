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

  Future<void> onTapBoost(Status status) async {
    if (status.reblogged == null || state.isLoading) return;
    setLoading(true);
    if (status.reblogged!) {
      final unboostedStatus = status.copyWith(
        reblogged: false,
        reblogsCount: status.reblogsCount - 1,
      );
      _setStatus(unboostedStatus);
      await MastodonRepository.instance.undoBoostStatus(
        status.id,
      );
    } else {
      final boostedStatus = status.copyWith(
        reblogged: true,
        reblogsCount: status.reblogsCount + 1,
      );
      _setStatus(boostedStatus);
      await MastodonRepository.instance.boostStatus(
        status.id,
      );
    }
    setLoading(false);
  }

  Future<void> onTapFavorite(Status status) async {
    if (status.favourited == null || state.isLoading) return;
    setLoading(true);
    if (status.favourited!) {
      final unfavouritedStatus = status.copyWith(
        favourited: false,
        favouritesCount: status.favouritesCount - 1,
      );
      _setStatus(unfavouritedStatus);
      await MastodonRepository.instance.undoFavoriteStatus(
        status.id,
      );
    } else {
      final favouritedStatus = status.copyWith(
        favourited: true,
        favouritesCount: status.favouritesCount + 1,
      );
      _setStatus(favouritedStatus);
      await MastodonRepository.instance.favoriteStatus(
        status.id,
      );
    }
    setLoading(false);
  }

  Future<void> deleteStatus(Status status) async {
    if (state.isLoading) return;
    setLoading(true);
    await MastodonRepository.instance.deleteStatus(status.id);
    final deletedStatuses = state.statuses.where((element) {
      return element.id != status.id;
    }).toList();
    _setStatuses(deletedStatuses);
    setLoading(false);
  }

  Future<void> pinStatusToProfile(Status status) async {
    if (state.isLoading) return;
    setLoading(true);
    await MastodonRepository.instance.pinStatusToProfile(status.id);
    setLoading(false);
  }

  Future<void> unpinStatusToProfile(Status status) async {
    if (state.isLoading) return;
    setLoading(true);
    await MastodonRepository.instance.unpinStatusToProfile(status.id);
    setLoading(false);
  }
}
