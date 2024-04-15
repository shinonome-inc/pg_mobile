import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/providers/favorite_status_list_notifier.dart';
import 'package:pg_mobile/util/date_formatter.dart';

class DebugFavoriteStatusListPage extends ConsumerStatefulWidget {
  const DebugFavoriteStatusListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugFavoriteStatusListPage> createState() =>
      _DebugFavoriteStatusListPageState();
}

class _DebugFavoriteStatusListPageState
    extends ConsumerState<DebugFavoriteStatusListPage> {
  final ScrollController _scrollController = ScrollController();
  Widget _replyOrRetweetOrFavoriteButton(int count, String imagePath) {
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
        ]
      ],
    );
  }

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        await ref
            .read(favoriteStatusListProvider.notifier)
            .fetchFavoriteStatusList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteStatusList = ref.watch(
      favoriteStatusListProvider.select((value) => value.favoriteStatusList),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入り一覧画面'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: favoriteStatusList.length,
        itemBuilder: (BuildContext context, int index) {
          final createAtDateTime =
              DateTime.parse(favoriteStatusList[index].createdAt);
          Widget content = Html(
            data: """
        ${favoriteStatusList[index].content}
        """,
          );
          if (index == favoriteStatusList.length - 1) {
            return const Center(
              child: CupertinoActivityIndicator(color: AppColors.white),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          favoriteStatusList[index].account.avatar),
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
                                      favoriteStatusList[index]
                                          .account
                                          .displayName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      "@${favoriteStatusList[index].account.username}",
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
                                      createAtDateTime),
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
                              _replyOrRetweetOrFavoriteButton(
                                favoriteStatusList[index].repliesCount,
                                "assets/images/statuses/reply.png",
                              ),
                              const Spacer(),
                              _replyOrRetweetOrFavoriteButton(
                                favoriteStatusList[index].reblogsCount,
                                "assets/images/statuses/retweet.png",
                              ),
                              const Spacer(),
                              _replyOrRetweetOrFavoriteButton(
                                favoriteStatusList[index].favouritesCount,
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
