import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/util/date_formatter.dart';
import 'package:pg_mobile/widgets/search_bar_widget.dart';

class DebugHomeTimelinePage extends ConsumerStatefulWidget {
  const DebugHomeTimelinePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugHomeTimelinePage> createState() =>
      _DebugHomeTimelinePageState();
}

class _DebugHomeTimelinePageState extends ConsumerState<DebugHomeTimelinePage> {
  late final ScrollController _scrollController;

  Widget _statusFavoriteOrRetweetOrReplyButton(
    BuildContext context,
    int count,
    String imagePath,
  ) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Image.asset(
            imagePath,
          ),
        ),
        const SizedBox(width: 4),
        if (count > 0) ...[
          Text(
            count.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.gray3),
          ),
        ],
      ],
    );
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
      body: ListView.builder(
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
          final createdAtDateTime = DateTime.parse(statusList[index].createdAt);
          Widget content = Html(
            data: """
              ${statusList[index].content}
            """,
            style: {"p": Style(color: AppColors.white)},
          );
          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(statusList[index].account.avatar),
                      radius: 28,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      statusList[index].account.displayName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      "@${statusList[index].account.username}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.gray3),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  DateFormatter.formatPastDate(
                                      createdAtDateTime),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.gray3),
                                ),
                              ],
                            ),
                          ),
                          content,
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              _statusFavoriteOrRetweetOrReplyButton(
                                context,
                                statusList[index].repliesCount,
                                "assets/images/statuses/reply.png",
                              ),
                              const Spacer(),
                              _statusFavoriteOrRetweetOrReplyButton(
                                context,
                                statusList[index].reblogsCount,
                                "assets/images/statuses/retweet.png",
                              ),
                              const Spacer(),
                              _statusFavoriteOrRetweetOrReplyButton(
                                context,
                                statusList[index].favouritesCount,
                                "assets/images/statuses/favorite.png",
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  "assets/images/statuses/three_point_leader.png",
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(
                  thickness: 1,
                  color: AppColors.gray2,
                  height: 0,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
