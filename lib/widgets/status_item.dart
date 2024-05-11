import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/status_footer_item.dart';

class StatusItem extends StatelessWidget {
  final Status status;
  const StatusItem({super.key, required this.status});

  Future<void> _onTapFavorite(Status status) async {
    if (status.favourited == null) return;
    if (status.favourited!) {
      await MastodonRepository.instance.undoFavoriteStatus(status.id);
    } else {
      await MastodonRepository.instance.favoriteStatus(status.id);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            status.createdAtText,
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
                        StatusFooterItem(
                          onTap: () {},
                          iconData: Icons.reply,
                          count: status.repliesCount,
                          color: AppColors.gray3,
                        ),
                        const Spacer(),
                        StatusFooterItem(
                          onTap: () {},
                          iconData: Icons.repeat,
                          count: status.reblogsCount,
                          color: AppColors.gray3,
                        ),
                        const Spacer(),
                        StatusFooterItem(
                          onTap: () => _onTapFavorite(status),
                          iconData: status.favourited!
                              ? Icons.star
                              : Icons.star_border,
                          count: status.favouritesCount,
                          color: status.favourited!
                              ? AppColors.yellow
                              : AppColors.gray3,
                        ),
                        const Spacer(),
                        SizedBox(
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
