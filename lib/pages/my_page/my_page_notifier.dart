import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/pages/my_page/my_page_state.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_page_notifier.g.dart';

@riverpod
class MyPageNotifier extends _$MyPageNotifier {
  final _repository = MastodonRepository.instance;

  @override
  MyPageState build() {
    return initialMyPageState;
  }

  void _setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void _setStatusesWithoutReply(List<Status> statuses) {
    state = state.copyWith(statusesWithoutReply: statuses);
  }

  void _setStatusesWithReply(List<Status> statuses) {
    state = state.copyWith(statusesWithReply: statuses);
  }

  void _setMediaStatuses(List<Status> statuses) {
    state = state.copyWith(mediaStatuses: statuses);
  }

  Future<void> fetchMyPageInfo() async {
    if (state.isLoading) return;

    final accountId = ref.read(signedInUserNotifierProvider)?.id;
    if (accountId == null) return;

    _setLoading(true);
    List<Status> statusesWithoutReply = [];
    List<Status> statusesWithReply = [];
    List<Status> mediaStatuses = [];
    try {
      statusesWithoutReply = await _repository.fetchAccountStatuses(
        accountId,
        excludeReplies: true,
      );
      statusesWithReply = await _repository.fetchAccountStatuses(
        accountId,
      );
      mediaStatuses = await _repository.fetchAccountStatuses(
        accountId,
        onlyMedia: true,
      );
      await ref
          .read(signedInUserNotifierProvider.notifier)
          .updateSignedInUser();
    } catch (e) {
      throw Exception('Failed to fetch statuses: $e');
    } finally {
      _setLoading(false);
    }
    _setStatusesWithoutReply(statusesWithoutReply);
    _setStatusesWithReply(statusesWithReply);
    _setMediaStatuses(mediaStatuses);
  }

  void _updateStatus(Status status) {
    _setStatusesWithoutReply(state.statusesWithoutReply.updateStatus(status));
    _setStatusesWithReply(state.statusesWithReply.updateStatus(status));
    _setMediaStatuses(state.mediaStatuses.updateStatus(status));
  }

  Future<void> boost(Status status) async {
    if (state.isLoading) return;
    _setLoading(true);
    _updateStatus(status.toggleReblogged);
    if (status.reblogged) {
      await _repository.undoBoostStatus(status.id);
    } else {
      await _repository.boostStatus(status.id);
    }
    _setLoading(false);
  }

  Future<void> favoriteStatus(Status status) async {
    if (state.isLoading) return;
    _setLoading(true);
    _updateStatus(status.toggleFavourited);
    if (status.favourited) {
      await _repository.undoFavoriteStatus(status.id);
    } else {
      await _repository.favoriteStatus(status.id);
    }
    _setLoading(false);
  }

  Future<void> pinStatus(Status status) async {
    if (state.isLoading) return;
    _setLoading(true);
    _updateStatus(status.togglePinned);
    if (status.pinned) {
      await _repository.unpinStatusToProfile(status.id);
    } else {
      await _repository.pinStatusToProfile(status.id);
    }
    _setLoading(false);
  }

  void _deleteStatusByStatusId(String statusId) {
    _setStatusesWithoutReply(
      state.statusesWithoutReply.removeStatusById(statusId),
    );
    _setStatusesWithReply(
      state.statusesWithReply.removeStatusById(statusId),
    );
    _setMediaStatuses(
      state.mediaStatuses.removeStatusById(statusId),
    );
  }

  Future<void> deleteStatus(Status status) async {
    if (state.isLoading) return;
    _setLoading(true);
    await _repository.deleteStatus(status.id);
    _deleteStatusByStatusId(status.id);
    _setLoading(false);
  }
}
