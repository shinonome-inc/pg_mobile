import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/status.dart';
import 'package:pg_mobile/widgets/search_bar_widget.dart';

class DebugHomeTimelinePage extends StatelessWidget {
  final List<Status> statuses;
  const DebugHomeTimelinePage({Key? key, required this.statuses})
      : super(key: key);

  Widget _betweenCreatedAtAndCurrentDifferenceText(
    int differenceDays,
    int differenceHours,
    int differenceMinutes,
    int differenceSeconds,
    BuildContext context,
  ) {
    if (differenceDays >= 1) {
      return Text(
        "${differenceDays.toString()}日前",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.gray3),
      );
    } else if (differenceDays == 0 && differenceHours >= 1) {
      return Text(
        "${differenceHours.toString()}時間前",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.gray3),
      );
    } else if (differenceDays == 0 &&
        differenceHours == 0 &&
        differenceMinutes >= 1) {
      return Text(
        "${differenceMinutes.toString()}分前",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.gray3),
      );
    } else {
      return Text(
        "${differenceSeconds.toString()}秒前",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.gray3),
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: SearchBarWidget(),
        ),
      ),
      body: ListView.builder(
        itemCount: statuses.length,
        itemBuilder: (BuildContext context, int index) {
          final createdAtDateTime = DateTime.parse(statuses[index].createdAt);
          final difference = DateTime.now().difference(createdAtDateTime);
          Widget content = Html(
            data: """
              ${statuses[index].content}
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
                          NetworkImage(statuses[index].account.avatar),
                      radius: 28,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              Text(
                                statuses[index].account.displayName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "@${statuses[index].account.username}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.gray3),
                              ),
                              const Spacer(),
                              _betweenCreatedAtAndCurrentDifferenceText(
                                difference.inDays,
                                difference.inHours,
                                difference.inMinutes,
                                difference.inSeconds,
                                context,
                              ),
                            ],
                          ),
                          content,
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              _statusFavoriteOrRetweetOrReplyButton(
                                context,
                                statuses[index].repliesCount,
                                "assets/images/statuses/reply.png",
                              ),
                              const Spacer(),
                              _statusFavoriteOrRetweetOrReplyButton(
                                context,
                                statuses[index].reblogsCount,
                                "assets/images/statuses/retweet.png",
                              ),
                              const Spacer(),
                              _statusFavoriteOrRetweetOrReplyButton(
                                context,
                                statuses[index].favouritesCount,
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
