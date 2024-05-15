import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
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

  Future<void> onTapReply(Status tappedStatus) async {
    Status updatedStatus;
    if (tappedStatus.reblogged!) {
      updatedStatus = await MastodonRepository.instance.undoBoostStatus(
        tappedStatus.id,
      );
    } else {
      updatedStatus = await MastodonRepository.instance.boostStatus(
        tappedStatus.id,
      );
    }
    final statuses = state.statuses
        .map((status) => status.id == updatedStatus.id
            ? tappedStatus.repliesCount > 0
                ? updatedStatus.copyWith(
                    repliesCount: updatedStatus.repliesCount - 1,
                  )
                : updatedStatus
            : status)
        .toList();
    state = state.copyWith(statuses: statuses);
  }

  Future<void> onTapBoost(Status tappedStatus) async {
    if (tappedStatus.reblogged == null) return;
    Status updatedStatus;
    if (tappedStatus.reblogged!) {
      updatedStatus = await MastodonRepository.instance.undoBoostStatus(
        tappedStatus.id,
      );
    } else {
      updatedStatus = await MastodonRepository.instance.boostStatus(
        tappedStatus.id,
      );
    }
    print('${updatedStatus.account.displayName}: ${updatedStatus.reblogged}');
    if (tappedStatus.reblogged!) {
      final statuses = state.statuses
          .map((status) => status.id == updatedStatus.id
              ? updatedStatus.copyWith(
                  reblogged: false,
                  reblogsCount: updatedStatus.reblogsCount - 1)
              : status)
          .toList();
      state = state.copyWith(statuses: statuses);
    } else {
      final statuses = state.statuses
          .map((status) => status.id == tappedStatus.id
              ? updatedStatus.copyWith(
                  reblogged: true,
                  reblogsCount: updatedStatus.reblogsCount + 1,
                )
              : status)
          .toList();
      state = state.copyWith(statuses: statuses);
    }

    // final statuses = state.statuses
    //     .map(
    //       (status) => status.id == tappedStatus.id
    //           ? tappedStatus.reblogged!
    //               ? updatedStatus.copyWith(
    //                   reblogged: false,
    //                   reblogsCount: updatedStatus.reblogsCount - 1,
    //                 )
    //               : updatedStatus.copyWith(
    //                   reblogged: true,
    //                   reblogsCount: updatedStatus.reblogsCount + 1,
    //                 )
    //           : status,
    //     )
    //     .toList();
  }

  Future<void> onTapFavorite(Status tappedStatus) async {
    if (tappedStatus.favourited == null) return;
    Status updatedStatus;
    if (tappedStatus.favourited!) {
      updatedStatus = await MastodonRepository.instance.undoFavoriteStatus(
        tappedStatus.id,
      );
    } else {
      updatedStatus = await MastodonRepository.instance.favoriteStatus(
        tappedStatus.id,
      );
    }
    final statuses = state.statuses
        .map((status) => status.id == updatedStatus.id
            ? tappedStatus.favourited!
                ? updatedStatus.copyWith(
                    favouritesCount: updatedStatus.favouritesCount - 1,
                  )
                : updatedStatus
            : status)
        .toList();
    state = state.copyWith(statuses: statuses);
  }
}
