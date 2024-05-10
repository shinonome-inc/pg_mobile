import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/widgets/search_bar_widget.dart';
import 'package:pg_mobile/widgets/status_item.dart';

class DebugHomeTimelinePage extends ConsumerStatefulWidget {
  const DebugHomeTimelinePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugHomeTimelinePage> createState() =>
      _DebugHomeTimelinePageState();
}

class _DebugHomeTimelinePageState extends ConsumerState<DebugHomeTimelinePage> {
  late final ScrollController _scrollController;

  Future<void> _onTapFavorite(Status status) async {
    if (status.favourited == null) return;
    if (status.favourited!) {
      await MastodonRepository.instance.undoFavoriteStatus(status.id);
    } else {
      await MastodonRepository.instance.favoriteStatus(status.id);
    }
  }

  // スクロールして一番下に行ったら、次のページの分のStatusを取得して表示
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        await ref.read(timelineProvider.notifier).fetchTimeline();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusList =
        ref.watch(timelineProvider.select((value) => value.timelineStatus));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: SearchBarWidget(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: pull to refreshで更新しているが、リアルタイム更新に修正する。
          final notifier = ref.read(timelineProvider.notifier);
          notifier.reset();
          notifier.fetchTimeline();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: statusList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == statusList.length) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.white,
                ),
              );
            }
            return StatusItem(status: statusList[index]);
          },
        ),
      ),
    );
  }
}
