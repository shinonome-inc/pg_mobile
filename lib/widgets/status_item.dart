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

  Future<void> _onTapBoost(Status status) async {
    if (status.reblogged == null) return;
    if (status.reblogged!) {
      await MastodonRepository.instance.undoBoostStatus(status.id);
    } else {
      await MastodonRepository.instance.boostStatus(status.id);
    }
  }

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.gray2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetworkImageContainer(
            imageUrl: status.account.avatar,
            width: 56.w,
            height: 56.w,
            boxShape: BoxShape.circle,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      status.account.displayName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Expanded(
                      child: Text(
                        '@${status.account.username}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.gray3),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      status.createdAtText,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.gray3),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
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
                SizedBox(height: 8.h),
                Row(
                  children: [
                    StatusFooterItem(
                      onTap: () {},
                      iconData: Icons.reply,
                      count: status.repliesCount,
                      color: AppColors.gray3,
                    ),
                    const Spacer(),
                    StatusFooterItem(
                      onTap: () => _onTapBoost(status),
                      iconData: Icons.repeat,
                      count: status.reblogsCount,
                      color:
                          status.reblogged! ? AppColors.blue : AppColors.gray3,
                    ),
                    const Spacer(),
                    StatusFooterItem(
                      onTap: () => _onTapFavorite(status),
                      iconData:
                          status.favourited! ? Icons.star : Icons.star_border,
                      count: status.favouritesCount,
                      color: status.favourited!
                          ? AppColors.yellow
                          : AppColors.gray3,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 24.w,
                      child:
                          const Icon(Icons.more_horiz, color: AppColors.gray3),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
