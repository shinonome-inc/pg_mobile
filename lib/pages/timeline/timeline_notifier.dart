import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/pages/timeline/timeline_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timeline_notifier.g.dart';

@riverpod
class TimelineNotifier extends _$TimelineNotifier {
  final _repository = MastodonRepository.instance;

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
    _setStatuses(state.statuses.updateStatus(status));
  }

  void _addStatuses(List<Status> statuses) {
    _setStatuses(state.statuses.addStatuses(statuses));
  }

  void _addStatus(Status status) {
    _setStatuses(state.statuses.addStatus(status));
  }

  Future<void> onRefresh() async {
    if (state.isLoading) return;
    _reset();
    await fetchTimeline();
  }

  Future<void> fetchTimeline() async {
    if (state.isLoading) return;
    setLoading(true);
    final fetchedStatuses = await _repository.fetchStatus();
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
      postedStatus = await _repository.postNewStatus(
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
      final repliedPreviousStatus =
          state.statuses.findStatusFromId(inReplyToId);
      final repliedAfterStatus = repliedPreviousStatus.copyWith(
          repliesCount: repliedPreviousStatus.repliesCount + 1);
      _setStatus(repliedAfterStatus);
    }
    _addStatus(postedStatus);
  }

  Future<void> onTapBoost(Status status) async {
    if (state.isLoading) return;
    final reblogged = status.reblogged ?? false;
    setLoading(true);
    final updatedStatus = status.copyWith(
      reblogged: !reblogged,
      reblogsCount: status.reblogsCount + (reblogged ? -1 : 1),
    );
    _setStatus(updatedStatus);
    if (reblogged) {
      await _repository.undoBoostStatus(status.id);
    } else {
      await _repository.boostStatus(status.id);
    }
    setLoading(false);
  }

  Future<void> onTapFavorite(Status status) async {
    if (state.isLoading) return;
    final favourited = status.favourited ?? false;
    setLoading(true);
    final updatedStatus = status.copyWith(
      favourited: !favourited,
      favouritesCount: status.favouritesCount + (favourited ? -1 : 1),
    );
    _setStatus(updatedStatus);
    if (favourited) {
      await _repository.undoFavoriteStatus(status.id);
    } else {
      await _repository.favoriteStatus(status.id);
    }
    setLoading(false);
  }

  Future<void> deleteStatus(Status status) async {
    if (state.isLoading) return;
    setLoading(true);
    await _repository.deleteStatus(status.id);
    final deletedStatuses = state.statuses.removeStatusById(status.id);
    _setStatuses(deletedStatuses);
    setLoading(false);
  }

  Future<void> pinStatusToProfile(Status status) async {
    if (state.isLoading || status.isPinnedToProfile) return;
    setLoading(true);
    final pinnedStatus = await _repository.pinStatusToProfile(status.id);
    _setStatus(pinnedStatus);
    setLoading(false);
  }

  Future<void> unpinStatusToProfile(Status status) async {
    if (state.isLoading || !status.isPinnedToProfile) return;
    setLoading(true);
    final unpinnedStatus = await _repository.unpinStatusToProfile(status.id);
    _setStatus(unpinnedStatus);
    setLoading(false);
  }

  Future<void> muteAccount(Account account) async {
    if (state.isLoading) return;
    setLoading(true);
    await _repository.muteAccount(account.id);
    final filteredStatuses = state.statuses.filterOutByAccountId(account.id);
    _setStatuses(filteredStatuses);
    setLoading(false);
  }
}
