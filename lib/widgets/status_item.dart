import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/status_footer_item.dart';
import 'package:pg_mobile/widgets/status_link_preview.dart';
import 'package:pg_mobile/widgets/status_media_view.dart';

class StatusItem extends ConsumerStatefulWidget {
  const StatusItem({
    Key? key,
    required this.status,
    this.reblogAccount,
  }) : super(key: key);

  final Status status;
  final Account? reblogAccount;

  @override
  ConsumerState<StatusItem> createState() => _StatusItemState();
}

class _StatusItemState extends ConsumerState<StatusItem> {
  void _onTapReply(Status tappedStatus) {
    NavigatorUtil.showNewPostCreateView(context, replyToStatus: tappedStatus);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(timelineProvider.notifier);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.gray2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.reblogAccount != null)
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 40.w),
                    const Icon(
                      Icons.repeat,
                      color: AppColors.gray3,
                    ),
                    Text(
                      '${widget.reblogAccount!.username}さんがブースト',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.gray3),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkImageContainer(
                imageUrl: widget.status.account.avatar,
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
                          widget.status.account.displayName,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            '@${widget.status.account.username}',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.gray3),
                          ),
                        ),
                        Text(
                          widget.status.createdAtText,
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
                      widget.status.contentText,
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
                    if (widget.status.mediaAttachments.isNotEmpty) ...{
                      SizedBox(
                        height: 160.h,
                        child: StatusMediaView(
                          mediaAttachments: widget.status.mediaAttachments,
                        ),
                      ),
                      SizedBox(height: 8.h),
                    },
                    if (widget.status.showLinkPreview) ...{
                      StatusLinkPreview(
                        url: widget.status.urls.first,
                      ),
                      SizedBox(height: 8.h),
                    },
                    Row(
                      children: [
                        StatusFooterItem(
                          onTap: () => NavigatorUtil.showNewPostCreateView(
                            context,
                            replyToStatus: widget.status,
                          ),
                          iconData: Icons.reply,
                          count: widget.status.repliesCount,
                          color: AppColors.gray3,
                        ),
                        const Spacer(),
                        StatusFooterItem(
                          onTap: () => notifier.onTapBoost(widget.status),
                          iconData: Icons.repeat,
                          count: widget.status.reblogsCount,
                          color: widget.status.reblogged!
                              ? AppColors.blue
                              : AppColors.gray3,
                        ),
                        const Spacer(),
                        StatusFooterItem(
                          onTap: () => notifier.onTapFavorite(widget.status),
                          iconData: widget.status.favourited!
                              ? Icons.star
                              : Icons.star_border,
                          count: widget.status.favouritesCount,
                          color: widget.status.favourited!
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
