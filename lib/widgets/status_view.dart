import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/util/date_formatter.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/status_icon_button.dart';

class StatusView extends StatelessWidget {
  final Status status;
  const StatusView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final createdAtDateTime = DateTime.parse(status.createdAt);
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkImageContainer(
                imageUrl: status.account.avatar,
                width: 56.w,
                height: 56.h,
                boxShape: BoxShape.circle,
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
                                status.account.displayName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                '@${status.account.username}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.gray3),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            DateFormatter.formatPastDate(createdAtDateTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.gray3),
                          ),
                        ],
                      ),
                    ),
                    LinkableText(
                      status.contentText,
                      onTapMention: (value) {
                        // TODO: ユーザー画面へ遷移する。
                        debugPrint('on tap mention: $value');
                      },
                      onTapHashtag: (value) {
                        // TODO: ハッシュタグ画面へ遷移する。
                        debugPrint('on tap hashtag: $value');
                      },
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8.w),
                        StatusIconButton(
                          iconData: Icons.reply,
                          count: status.repliesCount,
                        ),
                        const Spacer(),
                        StatusIconButton(
                          iconData: Icons.repeat,
                          count: status.reblogsCount,
                        ),
                        const Spacer(),
                        StatusIconButton(
                          iconData: Icons.star_border,
                          count: status.favouritesCount,
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: const Icon(Icons.more_horiz,
                              color: AppColors.gray3),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(
            thickness: 1,
            color: AppColors.gray2,
            height: 0,
          )
        ],
      ),
    );
  }
}
